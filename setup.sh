#!/bin/bash

# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"

function log_progress(  ) {
	echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] $1"; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne "."; sleep 0.3; echo -ne ".${endColour}"; sleep 0.3
}

# Install/update if necessary
if [ "$(id -u)" == "0" ]; then
	sleep 0.1
	adir=$(pwd)
	cd /
	echo -e "\n${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Preparing the setup for working properly.${endColour}"
	git_dir=$(timeout 10 bash -c "dirname $(find \-name .wef.config -type f 2>/dev/null | head -n 1)")
	# libbluetooth: Workaround for pybluez dependency https://github.com/themagpimag/magpi-issue61/issues/1
	apt install libbluetooth-dev moreutils -y &>/dev/null

	cd ${git_dir}
	git clean -f 2>/dev/null
	git pull 2>/dev/null
	sleep 0.2

	# Directories structure
	log_progress "Creating directories structure" &
	l=$!
	mkdir /opt/wef \
			/opt/wef/main \
			/opt/wef/main/bluetooth \
			/opt/wef/main/wordlists \
			/opt/wef/main/captures \
			/opt/wef/main/templates \
			/opt/wef/main/logs \
			/opt/wef/extra 2>/dev/null
	kill $l 2>/dev/null
	sleep 0.4

	log_progress "Installing modules and other things" &
	l=$!
	if [ ! -f "/opt/wef/extra/delete-creds.sh" ]; then
		touch /opt/wef/extra/delete-creds.sh
		chmod +x /opt/wef/extra/delete-creds.sh
		echo "#!/bin/bash" >> /opt/wef/extra/delete-creds.sh
		echo 'echo "" > /opt/wef/main/templates/*/datos-privados.txt' >> /opt/wef/extra/delete-creds.sh
		echo 'echo "" > /opt/wef/main/templates/*/usernames.txt' >> /opt/wef/extra/delete-creds.sh
	fi

	if [ ! -d "/opt/wef/main/templates" ]; then
		cp templates/* /opt/wef/main/templates -r 2>/dev/null
	fi

	if [ ! -d "/opt/wef/extra/gps-sdr-sim" ]; then
		git clone https://github.com/osqzss/gps-sdr-sim &>/dev/null
		mv gps-sdr-sim /opt/wef/extra/ 2>/dev/null
		pushd /opt/wef/extra/gps-sdr-sim/ &>/dev/null
		gcc gpssim.c -lm -O3 -o gps-sdr-sim 2>/dev/null
		popd &>/dev/null
	fi
	kill $l 2>/dev/null

	if [ ! -f "/opt/wef/main/wordlists/rockyou.txt" ]; then
		log_progress "Downloading necesary files, this will take some time" &
		l=$!
		wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" &>/dev/null
		mv rockyou.txt.gz /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
		gunzip /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
		wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" &>/dev/null
		mv probable-v2-wpa-top4800.txt /opt/wef/main/wordlists/ 2>/dev/null
		wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" &>/dev/null
		mv darkweb2017-top10000.txt /opt/wef/main/wordlists/ 2>/dev/null
		kill $l 2>/dev/null
	fi

	# Giving permissions to files
	cp WEF /usr/bin/wef 2>/dev/null
	cp WEF /opt/wef/wef 2>/dev/null
	cp clear.sh /opt/wef/clear-logs.sh 2>/dev/null
	cp uninstaller.sh /opt/wef/uninstaller.sh 2>/dev/null
	cp setup.sh /opt/wef/update.sh 2>/dev/null
	cp -r templates /opt/wef/main 2>/dev/null
	chmod +x WEF 2>/dev/null
	chmod +x /opt/wef/wef 2>/dev/null
	chmod +x /usr/bin/wef 2>/dev/null
	chmod +x /opt/wef/clear-logs.sh 2>/dev/null
	chmod +x uninstaller.sh 2>/dev/null
	chmod +x /opt/wef/update.sh 2>/dev/null
	chmod +x /opt/wef/uninstaller.sh 2>/dev/null
	chmod +x clear.sh 2>/dev/null
	chmod +x setup.sh 2>/dev/null

	log_progress "Installing dependencies" &
	l=$!
	pip3 install -r requirements.txt  &>/dev/null
	kill $l 2>/dev/null
	sleep 0.2
	cd ${adir}
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Installation completed, I hope you enjoy WEF${endColour}"
	echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] You can execute it just by typing 'wef' in the terminal\n${endColour}"
	sleep 0.2
	exit 0
else
	echo -e "\n${blueColour}[${endColour}${yellowColour}X${endColour}${blueColour}] Please, execute the script as root\n${endColour}"
	exit 1
fi
