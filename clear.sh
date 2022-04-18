#!/bin/bash

# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"

# Main Function
for name in $(ls /opt/WEF/main/captures); do
  rm /opt/WEF/main/captures/$name/Capture-* 2>/dev/null
  rm /opt/WEF/main/captures/$name/pkmid_hashes 2>/dev/null
  rm /opt/WEF/main/captures/$name/pkmid_capture 2>/dev/null
  rm /opt/WEF/main/captures/$name/rainbowtables 2>/dev/null
done

sleep 0.5
echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Useless information cleared\n${endColour}"
