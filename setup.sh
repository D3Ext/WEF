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

# Install/update if necessary
if [ "$(id -u)" == "0" ]; then

  if [ -f "/opt/wef/wef.cnf" ]; then 
    # find the git repository directory from the well-known wef.cnf file location (in INI file format)
    git_dir=$(awk -F "=" '/repo_dir/ {print $2}' /opt/wef/wef.cnf)
  fi

  adir="$(pwd)/"
  echo -e "\n${blueC}[${yC}WEF${blueC}] Setup file${endC}"; sleep 0.75

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
  dependencies=(systemd iw hcxtools hcxdumptool xterm pixiewps bully mdk4 aircrack-ng hashcat john reaver hostapd hostapd-wpe dnsmasq iptables lighttpd moreutils lshw dhcp coreutils php pocl libxcrypt-compat macchanger)

  if [ "$system" != "Kali" ] && [ "$system" != "Parrot" ] && [ ! "$(echo ${system} | grep -i "arch")" ]; then
    echo -ne "\n${blueC}[${yC}*${blueC}] Supported OS not detected, do you want to continue? [y/n]: " && read c

    if [ "$c" == "y" ] || [ "$c" == "yes" ]; then
      echo -ne "${blueC}[${yC}*${blueC}] Which is your package manager? [apt/pacman]: " && read manager
    fi
  fi

  # Check the actual OS between the supported ones
  echo -e "\n${blueC}[${yC}*${blueC}] Installing required tools, this process may take some time (don't worry about possible errors)\n${endC}"
  sleep 2

  if [ "$system" == "Kali" ] || [ "$system" == "Parrot" ] || [ "$manager" == "apt" ]; then
    for req in ${dependencies[@]}; do
      apt install ${req} -y
      sleep 0.1
    done
  elif [ "$(echo "${system}" | grep -i "arch")" ] || [ "$manager" == "pacman" ]; then
    for req in ${dependencies[@]}; do
      pacman -S ${req} --noconfirm --needed
      sleep 0.1
    done
  fi
  echo

  cd "${git_dir}"
  git clean -f 2>/dev/null
  git pull >/dev/null 2>&1
  sleep 1

  # Directories structure
  echo -e "${blueC}[${yC}*${blueC}] Creating directories structure${endC}"
  mkdir /opt/wef \
    /opt/wef/cache \
    /opt/wef/main \
    /opt/wef/main/wordlists \
    /opt/wef/main/captures \
    /opt/wef/main/logs 2>/dev/null

  cp -r captive-portals/ /opt/wef/main/
  sleep 0.4

  echo -e "${blueC}[${yC}*${blueC}] Installing/updating requirements and config files${endC}"
  sleep 0.3

  if [ ! -f "/opt/wef/main/wordlists/rockyou.txt" ]; then
    echo -e "${blueC}[${yC}*${blueC}] Downloading necessary wordlists${endC}"

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
    echo -e "${blueC}[${yC}*${blueC}] Creating config file (/opt/wef/wef.cnf)${endC}"
    touch /opt/wef/wef.cnf
    echo "repo_dir=${adir}" >> /opt/wef/wef.cnf
    echo "wef_dir=/opt/wef/" >> /opt/wef/wef.cnf
    echo "os=${system}" >> /opt/wef/wef.cnf
    echo "lang=en" >> /opt/wef/wef.cnf
    echo "use_colors=true" >> /opt/wef/wef.cnf
  fi; sleep 0.5

  # Giving permissions to files
  echo -e "${blueC}[${yC}*${blueC}] Moving files and uninstaller to /opt/wef${endC}"
  ln -s "${adir}src/WEF" /usr/bin/wef 2>/dev/null 
  cp src/WEF /opt/wef/wef 2>/dev/null
  cp src/clear.sh /opt/wef/clear-logs.sh 2>/dev/null
  cp src/uninstaller.sh /opt/wef/uninstaller.sh 2>/dev/null
  cp setup.sh /opt/wef/update.sh 2>/dev/null
  chmod +x src/WEF \
      /opt/wef/wef \
      /opt/wef/clear-logs.sh \
      src/uninstaller.sh \
      /opt/wef/update.sh \
      /opt/wef/uninstaller.sh \
      src/clear.sh \
      setup.sh 2>/dev/null

  sleep 0.4
  cd "${adir}"
  echo -e "\n${blueC}[${greenC}+${blueC}] Installation completed, I hope you enjoy WEF${endC}"
  echo -e "${blueC}[${greenC}+${blueC}] You can use the tool just by executing 'wef' in the terminal\n${endC}"
  exit 0

else
  echo -e "\n${blueC}[${yC}X${blueC}] Please, execute the script as root\n${endC}"
  exit 1
fi

