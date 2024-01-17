#!/bin/bash

# Colors
yC="\e[0;33m\033[1m"
blueC="\e[0;34m\033[1m"
greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"

# Check uid
if [ "$(id -u)" == "0" ]; then
  echo -ne "${blueC}[${yC}*${blueC}] Uninstalling WEF...${endC}"
  
  # Remove program from path and the wef folder structure under /opt/wef/
  rm -rf /opt/wef \
    /usr/bin/wef 2>/dev/null
  
  sleep 0.5
  echo -e "${blueC}[${greenC}+${blueC}] WEF uninstalled successfully${endC}"
else
  echo -e "${blueC}[${yC}X${blueC}] Please, execute the script as root${endC}"
  exit 0
fi
