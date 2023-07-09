#!/bin/bash

# Restore previous VIF changes and set interface to managed mode (done with create_vif.sh)
# by D3Ext

if [ "$(id -u)" != "0" ]; then
  echo -e "Execute as root!"
  exit 0
fi

if [ "$1" ] && [ "$2" ]; then
  iw "$2" del
  ifconfig "$1" down
  iwconfig "$1" mode managed
  ifconfig "$1" up
  echo -e "Changes reverted!"

else
  echo -e "Usage: restore_vif.sh <interface> <vif_to_delete>"
  echo -e "Example: restore_vif.sh wlan0 monwlan0"
  echo -e "Only use this if VIF was created with create_vif.sh script"
  exit 0
fi

