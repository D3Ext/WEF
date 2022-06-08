#!/bin/bash

echo -ne "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Uninstalling WEF"; sleep 0.5; echo -ne ""; sleep 0.5; echo -ne ""; sleep 0.5; echo -ne ".${endColour}"; sleep 0.5
rm -rf /opt/wef 2>/dev/null
rm /usr/bin/wef 2>/dev/null
sleep 1
echo -e "\n${blueColour}[${endColour}${yellowColour}+${endColour}${blueColour}] Uninstalled successfully${endColour}"
sleep 0.3
