#!/bin/bash

# ---------------
#
# WEF setup/update file
#
# ---------------

# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"

function log_progress(  ) {
	# The main logging loop
	echo -ne "\n--- ${blueColour} $1 ";
	spin='-\|/'
	i=0
	while :
	do
		i=$(( (i+1) %4 ))
		printf "\r${blueColour}[${yellowColour}${spin:$i:1}"
		printf "${blueColour}]"
		sleep .1
	done
}

function log_p() {
	# This function creates a loading spinner + message until another log_p is called
	if [ "$last_p" != "" ]; then
		stop_p
	fi
	log_progress "${1}" & 2>/dev/null
	last_p=$!
}

function stop_p() {
	#This function stops any existing progress message
	kill "${last_p}" 2>/dev/null
	printf "\r${blueColour}[${yellowColour}+${blueColour}]"
}

# Install/update if necessary
if [ "$(id -u)" == "0" ]; then
	sleep 0.1

	if [ -f "/opt/wef/wef.cnf" ]; then 
		# find the git repository directory from the well-known wef.cnf file location (in INI file format)
		git_dir=$(awk -F "=" '/repo_dir/ {print $2}' /opt/wef/wef.cnf)
	fi

	adir="$(pwd)/"
	echo -e "\n${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Preparing the setup for working properly.${endColour}"
	if [ ! "${git_dir}" ]; then
		# In the case this is the first setup or wef.cnf was deleted

		if [ -d ".git" ]; then
			# If there are git files in this dir
			echo -ne "\n${blueColour}[${redColour}+${blueColour}] Using $(pwd)/ as the WEF repo \n${endColour}"
			git_dir=$(pwd)
		else
			printf "\n${blueColour}[${redColour}X${blueColour}]${endColour} ERROR: Cannot find WEF repository location, please execute this script inside where it was cloned"
			printf "\n${blueColour}[${redColour}X${blueColour}]${endColour} ABORTING..."
			exit 1
		fi

		#git_dir=$(timeout 15 bash -c "dirname $(find \-name wef.cnf -type f 2>/dev/null | head -n 1)")
	fi
	system=$(cat /etc/os-release | grep '^NAME=' | awk '{print $1}' FS=' ' | awk '{print $2}' FS='"')

	# libbluetooth: Workaround for pybluez dependency https://github.com/themagpimag/magpi-issue61/issues/1
	apt install libbluetooth-dev moreutils -y &>/dev/null

	# Check the actual OS between the supported ones
	if [ "${system}" == "Kali" ] || [ "${system}" == "Parrot" ] || [ "${system}" == "Ubuntu"  ]; then
		apt install hcxtools -y &>/dev/null
	elif [ "${system}" == "Arch" ]; then
		pacman -S hcxtools --no-confirm &>/dev/null
	fi

	cd "${git_dir}"
	git clean -f 2>/dev/null
	git pull >/dev/null 2>&1

	# Directories structure
	# Check if /opt/wef/main/ exists and create neccessary structure
	if [ ! -d "/opt/wef/main" ]; then
		log_p "Creating directories structure"
		mkdir /opt/wef \
				/opt/wef/main \
				/opt/wef/main/bluetooth \
				/opt/wef/main/wordlists \
				/opt/wef/main/captures \
				/opt/wef/main/templates \
				/opt/wef/main/logs \
				/opt/wef/extra 2>/dev/null
		sleep 0.4
	fi

	log_p "Installing/updating modules and other things"
	# Check if the script to delete credentials from evil twin exists
	if [ ! -f "/opt/wef/extra/delete-creds.sh" ]; then
		touch /opt/wef/extra/delete-creds.sh
		chmod +x /opt/wef/extra/delete-creds.sh
		echo "#!/bin/bash" >> /opt/wef/extra/delete-creds.sh
		echo 'echo "" > /opt/wef/main/templates/*/datos-privados.txt' >> /opt/wef/extra/delete-creds.sh
		echo 'echo "" > /opt/wef/main/templates/*/usernames.txt' >> /opt/wef/extra/delete-creds.sh
	fi

	# Check if the templates folder exists
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

	if [ ! -f "/opt/wef/main/wordlists/rockyou.txt" ]; then
		log_p "Downloading necesary files, this will take some time"
		wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" &>/dev/null
		mv rockyou.txt.gz /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
		gunzip /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
		wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" &>/dev/null
		mv probable-v2-wpa-top4800.txt /opt/wef/main/wordlists/ 2>/dev/null
		wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" &>/dev/null
		mv darkweb2017-top10000.txt /opt/wef/main/wordlists/ 2>/dev/null
	fi

	# Check if the wef config file exists in /opt/wef/
	if [ ! -f "/opt/wef/wef.cnf" ]; then
		touch /opt/wef/wef.cnf
		echo "repo_dir=${adir}" >> /opt/wef/wef.cnf
		echo "wef_dir=/opt/wef/" >> /opt/wef/wef.cnf
		echo "os=${system}" >> /opt/wef/wef.cnf
		echo "the_best_pentester=D3Ext" >> /opt/wef/wef.cnf
		echo "the_best_coder=ultrazar" >> /opt/wef/wef.cnf
	fi

	# Giving permissions to files
	ln -s "${adir}src/WEF" /usr/bin/wef 2>/dev/null 
	cp src/WEF /opt/wef/wef 2>/dev/null
	cp src/clear.sh /opt/wef/clear-logs.sh 2>/dev/null
	cp src/uninstaller.sh /opt/wef/uninstaller.sh 2>/dev/null
	cp setup.sh /opt/wef/update.sh 2>/dev/null
	cp -r templates /opt/wef/main 2>/dev/null
	chmod +x src/WEF \
			/opt/wef/wef \
			/opt/wef/clear-logs.sh \
			src/uninstaller.sh \
			/opt/wef/update.sh \
			/opt/wef/uninstaller.sh \
			src/clear.sh \
			setup.sh 2>/dev/null


	log_p "Installing some dependencies"
	pip3 install -r requirements.txt &>/dev/null
	stop_p

	sleep 0.2
	cd "${adir}"
	echo -e "\n\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Installation/update completed, I hope you enjoy WEF${endColour}"
	echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] You can execute it just by typing 'wef' in the terminal\n${endColour}"
	sleep 0.2
	exit 0
else
	echo -e "\n${blueColour}[${endColour}${yellowColour}X${endColour}${blueColour}] Please, execute the script as root\n${endColour}"
	exit 1
fi
