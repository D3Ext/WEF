#!/bin/bash

# Colors
yC="\e[0;33m\033[1m"
blueC="\e[0;34m\033[1m"
greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"

# Check uid
if [ "$(id -u)" == "0" ]; then
  echo -ne "\n${blueC}[${yC}+${blueC}] Uninstalling WEF"; sleep 0.5; echo -ne "."; sleep 0.5; echo -ne "."; sleep 0.5; echo -ne ".${endC}"; sleep 0.5
  
  # Remove program from path and the wef folder structure under /opt/wef/
  rm -rf /opt/wef \
    /usr/bin/wef 2>/dev/null
  
  sleep 1
  echo -e "\n${blueC}[${greenC}+${blueC}] WEF uninstalled successfully${endC}"
  sleep 0.2
else
  echo -e "\n${blueC}[${yC}X${blueC}] Please, execute the script as root${endC}"
  exit 0
fi
