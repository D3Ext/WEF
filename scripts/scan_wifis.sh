#!/bin/bash

# Scan nearby APs on selected band with timeout
# by D3Ext

if [ "$(id -u)" != "0" ]; then
  echo -e "Execute as root!"
  exit 0
fi

if [ "$1" ] && [ "$2" ] && [ "$3" ]; then

  echo -e "Enabling monitor mode..."
  airmon-ng start "$1" &>/dev/null; sleep 0.3; echo

  if [ -d "/sys/class/net/$1" ]; then
    netCard="$1"
  elif [ -d "/sys/class/net/${1}mon" ]; then
    netCard="${1}mon"
  fi

  if [ "$2" == "2.4" ]; then
    timeout "$3" bash -c "wash -i ${netCard} -a -s -2"

  elif [ "$2" == "5" ]; then
    timeout "$3" bash -c "wash -i ${netCard} -a -s -5"

  elif [ "$2" == "both" ]; then
    timeout "$3" bash -c "wash -i ${netCard} -a -s -2 -5"

  else
    echo -e "Invalid band! Allowed values: 2.4/5/both"
    exit 0
  fi

  echo -e "\nDisabling monitor mode..."
  airmon-ng stop "${netCard}" &>/dev/null
  exit 0

else
  echo -e "Usage: scan_wifis.sh <interface> <band> <duration>"
  echo -e "\t<interface>: interface in managed mode (i.e. wlan0)"
  echo -e "\t<band>: band in which to scan APs (2.4/5/both)"
  echo -e "\t<duration>: scan duration (i.e. 1m)\n"
  echo -e "Example using 2.4Ghz: scan_wifis.sh wlan0 2.4 40s"
  echo -e "Example using 2.4 and 5 Ghz: scan_wifis.sh wlan0 both 40s"
  exit 0
fi


