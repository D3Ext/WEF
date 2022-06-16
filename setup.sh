#!/bin/bash

# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"

if [ "$(id -u)" == "0" ]; then
	sleep 0.1
	adir=$(pwd)
	echo -e "\n${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Preparing the setup for working properly.${endColour}"
	sleep 0.5
	echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Creating directories"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne ".${endColour}"; sleep 0.3
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
	git clone https://github.com/osqzss/gps-sdr-sim &>/dev/null
	mv gps-sdr-sim /opt/wef/extra/ 2>/dev/null
	pushd /opt/wef/extra/gps-sdr-sim/ &>/dev/null
	gcc gpssim.c -lm -O3 -o gps-sdr-sim 2>/dev/null
	popd &>/dev/null
	echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Downloading necesary files"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne ".${endColour}"; sleep 0.3
	wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" &>/dev/null
	mv rockyou.txt.gz /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
	gunzip /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" &>/dev/null
	mv probable-v2-wpa-top4800.txt /opt/wef/main/wordlists/ 2>/dev/null
	wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" &>/dev/null
	mv darkweb2017-top10000.txt /opt/wef/main/wordlists/ 2>/dev/null
	echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Giving permissions to different files"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne ".${endColour}"; sleep 0.3
	sleep 0.4
	cp ${adir}/WEF /usr/bin/wef 2>/dev/null
	cp ${adir}/WEF /opt/wef/wef 2>/dev/null
	cp ${adir}/clear.sh /opt/wef/clear-logs.sh 2>/dev/null
	cp ${adir}/uninstaller.sh /opt/wef/uninstaller.sh 2>/dev/null
	chmod +x WEF 2>/dev/null
	chmod +x /opt/wef/wef 2>/dev/null
	chmod +x /usr/bin/wef 2>/dev/null
	chmod +x /opt/wef/clear-logs.sh 2>/dev/null
	chmod +x uninstaller.sh 2>/dev/null
	chmod +x /opt/wef/uninstaller.sh 2>/dev/null
	chmod +x ${adir}/clear.sh 2>/dev/null
	rm ${adir}/setup.sh 2>/dev/null
	echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Installing requirements"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne ".${endColour}"; sleep 0.3
	pip3 install -r requirements.txt &>/devnull
	apt install moreutils -y &>/dev/null
	sleep 0.2
	echo -e "\n\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Installation completed, I hope you enjoy WEF${endColour}"
	echo -e "${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] You can execute it just by typing 'wef' in the terminal\n${endColour}"
	sleep 0.2
	exit 0
else
	echo -e "\n${blueColour}[${endColour}${yellowColour}X${endColour}${blueColour}] Please, execute the script as root\n${endColour}"
	exit 1
fi
