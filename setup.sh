#!/bin/bash

if [ "$(id -u)" == "0" ]; then
sleep 0.1
	adir=$(pwd)
	echo -e "\n[WEF] Creating the setup for working properly.\n"
	mkdir /opt/WEF 2>/dev/null
	mkdir /opt/WEF/main 2>/dev/null
	mkdir /opt/WEF/main/img 2>/dev/null
	mkdir /opt/WEF/main/modules 2>/dev/null
	mkdir /opt/WEF/main/wordlists 2>/dev/null
	mkdir /opt/WEF/main/captures 2>/dev/null
	mkdir /opt/WEF/main/logs 2>/dev/null
	wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" &>/dev/null
	mv rockyou.txt.gz /opt/WEF/main/wordlists/rockyou.txt.gz 2>/dev/null
	gunzip /opt/WEF/main/wordlists/rockyou.txt.gz 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" &>/dev/null
	mv probable-v2-wpa-top4800.txt /opt/WEF/main/wordlists/ 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" &>/dev/null
	mv darkweb2017-top10000.txt /opt/WEF/main/wordlists/ 2>/dev/null
	wget "https://raw.githubusercontent.com/LionSec/xerosploit/master/tools/bettercap/modules/replace_images.rb" &>/dev/null
	mv replace_images.rb /opt/WEF/main/modules/ 2>/dev/null
	cp ${adir}/WEF /usr/bin/wef 2>/dev/null
	cp ${adir}/WEF /opt/WEF/WEF 2>/dev/null
	cp ${adir}/clear.sh /opt/WEF/clear-logs.sh 2>/dev/null
	chmod +x WEF 2>/dev/null
	chmod +x /opt/WEF/WEF 2>/dev/null
	chmod +x /usr/bin/wef 2>/dev/null
	chmod +x /opt/WEF/clear-logs.sh 2>/dev/null
	rm ${adir}/setup.sh 2>/dev/null
	echo -e "[+] Installation completed"
else
	echo -e "\n[X] Please, execute the script as root.\n"
	exit 1
fi
