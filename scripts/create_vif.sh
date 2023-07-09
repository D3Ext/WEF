#!/bin/bash

# Create a virtual interface and enable monitor mode on interface (revert this with revert_vif.sh)
# by D3Ext

if [ "$(id -u)" != "0" ]; then
  echo -e "Execute as root!"
  exit 0
fi

if [ "${1}" ] && [ "${2}" ]; then
  if hash rfkill 2> /dev/null; then
    rfkill unblock all > /dev/null 2>&1
  fi

  ip link set "${1}" down
  iw "${1}" set monitor control
  ip link set "${1}" up

  rand_mac=$(hexdump -n 6 -ve '1/1 "%.2x "' /dev/random | awk -v a="2,6,a,e" -v r="$RANDOM" 'BEGIN{srand(r);}NR==1{split(a,b,",");r=int(rand()*4+1);printf "%s%s:%s:%s:%s:%s:%s\n",substr($1,0,1),b[r],$2,$3,$4,$5,$6}')
  iw "${1}" interface add "${2}" type monitor addr ${rand_mac}

  echo -e "Interface created successfully"
else
  echo -e "Usage: create_vif.sh <interface> <new_vif_name>"
  echo -e "Example: create_vif.sh wlan0 monwlan0"
  echo -e "Use restore_vif.sh to revert changes"
  exit 0
fi

