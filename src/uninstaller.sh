#!/bin/bash

# Colors
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"

# Check uid
if [ "$(id -u)" == "0" ]; then
  echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Uninstalling WEF"; sleep 0.5; echo -ne "."; sleep 0.5; echo -ne "."; sleep 0.5; echo -ne ".${endColour}"; sleep 0.5
  # Remove program from path and the wef folder structure under /opt/wef/
  rm -rf /opt/wef 2>/dev/null
  rm /usr/bin/wef 2>/dev/null
  sleep 1
  echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] WEF uninstalled successfully${endColour}"
  sleep 0.2
else
  echo -e "\n${blueColour}[${endColour}${yellowColour}X${endColour}${blueColour}] Please, execute the script as root${endColour}"
  exit 0
fi
