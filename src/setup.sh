#!/bin/bash

#
# WEF installer script
# Thanks to ultrazar for installer/updater implementation
#

# Colors
greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"
blueC="\e[0;34m\033[1m"
yC="\e[0;33m\033[1m"
grayC="\e[0;37m\033[1m"

# Install/update if necessary
if [ "$(id -u)" == "0" ]; then

  if [ -f "/opt/wef/wef.cnf" ]; then 
    # find the git repository directory from wef.cnf file location (in INI file format)
    git_dir=$(awk -F "=" '/repo_dir/ {print $2}' /opt/wef/wef.cnf | sed 's/#.*//' | tr -d " ")
  fi

  adir="$(pwd)/"
  echo -e "${blueC}[${yC}WEF${blueC}] Setup file${endC}"; sleep 0.2

  if [ ! "${git_dir}" ]; then
    # In the case this is the first setup or wef.cnf was deleted
    if [ -d ".git" ]; then
      # If there are git files in this dir
      echo -e "\n${blueC}[${yC}*${blueC}] Using $(pwd)/ as WEF repo${endC}"
      git_dir=$(pwd)
    else
      printf "\n${blueC}[${yC}X${blueC}]${endC} ERROR: Cannot find WEF repository location, please execute this script inside where it was cloned"
      printf "\n${blueC}[${yC}X${blueC}]${endC} ABORTING..."
      exit 1
    fi
  fi

  #dependencies=(curl pciutils systemd wget ethtool nftables iw hcxtools hcxdumptool xterm pixiewps bully mdk4 aircrack-ng hashcat john reaver hostapd hostapd-wpe dnsmasq iptables lighttpd moreutils lshw dhcp coreutils php pocl libxcrypt-compat macchanger)

  cd "${git_dir}"
  #git clean -f 2>/dev/null
  #git pull >/dev/null 2>&1
  sleep 1

  # Directories structure
  if [ ! -d "/opt/wef/main" ]; then
    echo -e "${blueC}[${yC}*${blueC}] Creating directories structure${endC}"
    mkdir /opt/wef \
      /opt/wef/cache \
      /opt/wef/main \
      /opt/wef/main/captures \
      /opt/wef/main/logs \
      /opt/wef/main/graphs 2>/dev/null

    cp -r captive-portals/ /opt/wef/main/
    sleep 0.1
  fi
  sleep 0.3

  if [ ! -d /opt/wef/main/wordlists/ ]; then
    cp -r wordlists/ /opt/wef/main/ 2>/dev/null
    gunzip /opt/wef/main/wordlists/rockyou.txt.gz 2>/dev/null
  fi

  # Check if the wef config file exists in /opt/wef/
  if [ ! -f "/opt/wef/wef.cnf" ]; then
    echo -e "${blueC}[${yC}*${blueC}] Creating config file (/opt/wef/wef.cnf)${endC}"

    echo "# This is default config file
# This file must be saved as /opt/wef/wef.cnf
# Then you can edit it to make it much more flexible and to adapt to your requirements

# Default lenguage to use. Values: en, es
lang=en

# Colorize output (recommended to be enabled)
use_colors=true

# Enable/disable verbose by default (recommended to be enabled)
verbose=true

# Don't change repo_dir value unless you know what you are exactly doing, as it's generated during setup
repo_dir=${git_dir}" >> /opt/wef/wef.cnf
  fi; sleep 0.5

  # Giving permissions to files
  echo -e "${blueC}[${yC}*${blueC}] Moving files to /opt/wef/${endC}"
  cp src/wef /opt/wef/wef 2>/dev/null
  cp src/mac-vendors.json /opt/wef/mac-vendors.json 2>/dev/null
  cp setup.sh /opt/wef/update.sh 2>/dev/null
  ln -s /opt/wef/wef /usr/bin/wef 2>/dev/null
  chmod +x src/wef \
      /opt/wef/wef \
      /opt/wef/update.sh \
      setup.sh 2>/dev/null

  sleep 0.4
  cd "${adir}"
  echo -e "\n${blueC}[${greenC}+${blueC}] Process completed${endC}"
  echo -e "${blueC}[${greenC}+${blueC}] You can use the tool just by executing 'wef' in the terminal${endC}"
  exit 0

else
  echo -e "${blueC}[${yC}WEF${blueC}] Please, execute the script as root${endC}"
  exit 1
fi

