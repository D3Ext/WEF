#!/bin/bash

# ---------------
#
# WEF setup/update file
#
# ---------------

# Colors
greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"
rC="\e[0;31m\033[1m"
blueC="\e[0;34m\033[1m"
yC="\e[0;33m\033[1m"
grayC="\e[0;37m\033[1m"

function log_progress(  ) {
	# The main logging loop
	echo -ne "\n--- ${blueC} $1 ";
	spin='-\|/'
	i=0
	while :
	do
    i=$(( (i+1) %4 ))
    printf "\r${blueC}[${yC}${spin:$i:1}"
    printf "${blueC}]"
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
  printf "\r${blueC}[${yC}+${blueC}]"
}

# Install/update if necessary
if [ "$(id -u)" == "0" ]; then

  if [ -f "/opt/wef/wef.cnf" ]; then 
    # find the git repository directory from the well-known wef.cnf file location (in INI file format)
    git_dir=$(awk -F "=" '/repo_dir/ {print $2}' /opt/wef/wef.cnf)
  fi

  adir="$(pwd)/"
  echo -e "\n${blueC}[${yC}WEF${blueC}] Preparing the setup for working properly${endC}"
  if [ ! "${git_dir}" ]; then
    # In the case this is the first setup or wef.cnf was deleted

    if [ -d ".git" ]; then
      # If there are git files in this dir
      echo -ne "\n${blueC}[${rC}+${blueC}] Using $(pwd)/ as the WEF repo \n${endC}"
      git_dir=$(pwd)
    else
      printf "\n${blueC}[${rC}X${blueC}]${endC} ERROR: Cannot find WEF repository location, please execute this script inside where it was cloned"
      printf "\n${blueC}[${rC}X${blueC}]${endC} ABORTING..."
      exit 1
    fi

  fi
  system=$(cat /etc/os-release | grep '^NAME=' | awk '{print $1}' FS=' ' | awk '{print $2}' FS='"')

  dependencies=(systemctl iw hcxtools hcxdumptool xterm pixiewps bully mdk4 aircrack-ng hashcat john reaver hostapd hostapd-wpe dnsmasq iptables lighttpd moreutils lshw dhcp coreutils pocl libxcrypt-compat)
  # Check the actual OS between the supported ones
  if [ "${system}" == "Kali" ] || [ "${system}" == "Parrot" ]; then
    for req in ${dependencies[@]}; do
      apt install ${req} -y
    done
  elif [ "${system}" == "Arch" ]; then
    for req in ${dependencies[@]}; do
      pacman -S ${req} --noconfirm
    done
  fi
  echo

  cd "${git_dir}"
  git clean -f 2>/dev/null
  git pull >/dev/null 2>&1

  # Directories structure
  log_p "Creating directories structure"
  mkdir /opt/wef \
    /opt/wef/cache \
    /opt/wef/main \
    /opt/wef/main/wordlists \
    /opt/wef/main/captures \
    /opt/wef/main/logs 2>/dev/null
  sleep 0.1

  cp -r captive-portals/ /opt/wef/main/

  log_p "Installing/updating modules and other things"

  if [ ! -f "/opt/wef/main/wordlists/rockyou.txt" ]; then
    log_p "Downloading necessary wordlists, this will take some time"

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
    echo "lang=en" >> /opt/wef/wef.cnf
    echo "use_colors=true" >> /opt/wef/wef.cnf
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

  cd "${adir}"
  echo -e "\n\n${blueC}[${greenC}+${blueC}] Installation/update completed, I hope you enjoy WEF${endC}"
  echo -e "${blueC}[${greenC}+${blueC}] You can execute it just by typing 'wef' in the terminal\n${endC}"
  exit 0

else
  echo -e "\n${blueC}[${yC}X${blueC}] Please, execute the script as root\n${endC}"
  exit 1
fi

