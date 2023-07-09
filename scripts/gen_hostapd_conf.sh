#!/bin/bash

# Script to easily generate hostapd config files
# by D3Ext

if [ "$1" ] && [ "$2" ] && [ "$3" ] && [ "$4" ]; then

  if [ "$2" -le "14" ]; then
    band="g"
  else
    band="a"
  fi

  echo -e "interface=${1}
ssid=${3}
hw_mode=${band}
channel=${2}
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
ieee80211n=1
wme_enabled=1
driver=nl80211
" > "${4}"
  exit 0

else
  echo -e "Usage: gen_hostapd_conf.sh <interface> <channel> <essid> <output>"
  echo -e "\t<interface>: network interface to setup the AP"
  echo -e "\t<channel>: channel in which the AP will work into"
  echo -e "\t<essid>: name of AP"
  echo -e "\t<output>: file where config is writen to\n"
  echo -e "Example: gen_hostapd_conf wlan0 11 MyWifi hostapd.conf"
  exit 0
fi

