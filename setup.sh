#!/bin/bash

if [ "$(id -u)" == "0" ]; then
sleep 0.1
	adir=$(pwd)
	echo -e "\n[WEF] Preparing the setup for working properly."
	sleep 0.2
	echo -ne "\n[+] Creating directories."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2
	mkdir /opt/wef 2>/dev/null
	mkdir /opt/wef/main 2>/dev/null
	mkdir /opt/wef/main/img 2>/dev/null
	mkdir /opt/wef/main/modules 2>/dev/null
	mkdir /opt/wef/main/wordlists 2>/dev/null
	mkdir /opt/wef/main/captures 2>/dev/null
	mkdir /opt/wef/main/logs 2>/dev/null
	mv templates /opt/wef/main/ 2>/dev/null
	sleep 0.4
	echo -ne "\n[+] Downloading files."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2
	wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" &>/dev/null
	mv rockyou.txt.gz /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
	gunzip /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" &>/dev/null
	mv probable-v2-wpa-top4800.txt /opt/wef/main/wordlists/ 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" &>/dev/null
	mv darkweb2017-top10000.txt /opt/wef/main/wordlists/ 2>/dev/null
	wget "https://raw.githubusercontent.com/LionSec/xerosploit/master/tools/bettercap/modules/replace_images.rb" &>/dev/null
	echo -ne "\n[+] Giving permissions to necessary files."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2
	sleep 0.2
	cp replace_images.rb /opt/wef/main/modules/ 2>/dev/null
	cp ${adir}/WEF /usr/bin/wef 2>/dev/null
	cp ${adir}/WEF /opt/wef/wef 2>/dev/null
	cp ${adir}/clear.sh /opt/wef/clear-logs.sh 2>/dev/null
	chmod +x WEF 2>/dev/null
	chmod +x /opt/wef/wef 2>/dev/null
	chmod +x /usr/bin/wef 2>/dev/null
	chmod +x /opt/wef/clear-logs.sh 2>/dev/null
	rm ${adir}/setup.sh 2>/dev/null
	echo -ne "\n[+] Installing requirements."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2
	pip3 install -r requirements.txt
	sleep 0.2
	echo -e "\n[+] Installation completed\n"
	sleep 1
else
	echo -e "\n[X] Please, execute the script as root.\n"
	exit 1
fi
