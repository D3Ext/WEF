#!/bin/bash

if [ "$(id -u)" == "0" ]; then
sleep 0.1
	adir=$(pwd)
	echo -e "\n[WEF] Preparing the setup for working properly."
	sleep 0.5
	echo -ne "\n[+] Creating directories"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3
	mkdir /opt/wef 2>/dev/null
	mkdir /opt/wef/main 2>/dev/null
	mkdir /opt/wef/main/bluetooth 2>/dev/null
	mkdir /opt/wef/main/wordlists 2>/dev/null
	mkdir /opt/wef/main/captures 2>/dev/null
	mkdir /opt/wef/main/logs 2>/dev/null
	mkdir /opt/wef/extra 2>/dev/null
	touch /opt/wef/extra/delete-creds.sh
	chmod +x /opt/wef/extra/delete-creds.sh
	echo '#!/bin/bash' > /opt/wef/extra/delete-creds.sh
	echo 'echo "" > /opt/wef/main/templates/*/datos-privados.txt' >> /opt/wef/extra/delete-creds.sh
	echo 'echo "" > /opt/wef/main/templates/*/usernames.txt' >> /opt/wef/extra/delete-creds.sh
	mv templates /opt/wef/main/ 2>/dev/null
	sleep 0.7
	echo -ne "\n[+] Downloading necesary files"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3
	wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" &>/dev/null
	mv rockyou.txt.gz /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
	gunzip /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" &>/dev/null
	mv probable-v2-wpa-top4800.txt /opt/wef/main/wordlists/ 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" &>/dev/null
	mv darkweb2017-top10000.txt /opt/wef/main/wordlists/ 2>/dev/null
	echo -ne "\n[+] Giving permissions to different files"; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2; echo -ne "."; sleep 0.2
	sleep 0.4
	cp ${adir}/WEF /usr/bin/wef 2>/dev/null
	cp ${adir}/WEF /opt/wef/wef 2>/dev/null
	cp ${adir}/clear.sh /opt/wef/clear-logs.sh 2>/dev/null
	chmod +x WEF 2>/dev/null
	chmod +x /opt/wef/wef 2>/dev/null
	chmod +x /usr/bin/wef 2>/dev/null
	chmod +x /opt/wef/clear-logs.sh 2>/dev/null
	rm ${adir}/setup.sh 2>/dev/null
	echo -ne "\n[+] Installing requirements"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3
	pip3 install -r requirements.txt &>/dev/null
	apt install moreutils -y &>/dev/null
	sleep 0.2
	echo -e "\n[+] Installation completed, I hope you enjoy WEF\n"
	sleep 0.5
	exit 0
else
	echo -e "\n[X] Please, execute the script as root.\n"
	exit 1
fi
