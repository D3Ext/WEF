#!/bin/bash

# Colors
greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"
rC="\e[0;31m\033[1m"
blueC="\e[0;34m\033[1m"
yC="\e[0;33m\033[1m"
grayC="\e[0;37m\033[1m"

# Main Function
if [ "$(id -u)" == "0" ]; then
  # Remove captures (.pcap) and logs (custom files of WEF to store attacks info)
  rm -rf /opt/wef/main/captures/* 2>/dev/null
  rm -rf /opt/wef/main/logs/* 2>/dev/null

  sleep 0.4
  echo -e "\n${blueC}[${greenC}+${blueC}] Information and logs cleared\n${endC}"
  sleep 0.3
  # Simple function to remove the submitted credentials of the Evil AP if the user 
  echo -ne "\n${blueC}[${greenC}+${blueC}] Do you want to clear credentials from the EvilTwin attack? [y/n]: ${endC}" && read option
  if [ "${option}" == "y" ] || [ "${option}" == "yes" ]; then
    rm /opt/wef/main/templates/*/datos-privados.txt 2>/dev/null
    rm /opt/wef/main/templates/*/usernames.txt 2>/dev/null
  else
    echo -e "\n${blueC}[${greenC}+${blueC}] Bye!\n${endC}"
  fi
  
else
  echo -e "${blueC}[${yC}X${blueC}] Please, execute the script as root${endC}"
fi
