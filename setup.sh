#!/bin/bash

if [ "$(id -u)" == "0" ]; then
  sleep 0.1
  dir=$(pwd)
  echo -e "[WEF] Creating the setup for working properly."
  mkdir /opt/WEF 2>/dev/null
  mkdir /opt/WEF/main 2>/dev/null
  mdkir /opt/WEF/main/img 2>/dev/null
  mkdir /opt/WEF/main/modules 2>/dev/null
  mkdir /opt/WEF/main/wordlists 2>/dev/null
  mdkir /opt/WEF/main/captures 2>/dev/null
  mkdir /opt/WEF/main/logs 2>/dev/null
  wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" -o /opt/WEF/main/wordlists/rockyou.txt.gz &>/dev/null
  gunzip /opt/WEF/main/wordlists/rockyou.txt.gz 2>/dev/null
  wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" -o /opt/WEF/main/wordlists/probable-v2-wpa-top4800.txt &>/dev/null
  wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" -o /opt/WEF/main/wordlists/darkweb2017-top10000.txt &>/dev/null
  # wget "kaonashi" -o /opt/WEF/main/wordlists/
  wget "https://raw.githubusercontent.com/LionSec/xerosploit/master/tools/bettercap/modules/replace_images.rb" -o /opt/WEF/main/modules/replace_images.rb &>/dev/null
  wget "https://raw.githubusercontent.com/D3Ext/WEF/main/WEF.sh" -o /opt/WEF/WEF &>/dev/null
  wget "https://raw.githubusercontent.com/D3Ext/WEF/main/clear.sh" -o /opt/WEF/clear-logs.sh &>/dev/null
  chmod +x /opt/WEF/WEF 2>/dev/null
  cp /opt/WEF/WEF /usr/bin/WEF 2>/dev/null
  chmod +x /usr/bin/WEF 2>/dev/null
  chmod +x /opt/WEF/clear.sh 2>/dev/null
  rm ${dir}/setup.sh 2>/dev/null
else
  echo -e "[X] Please, execute the script as root"
  exit 1
fi
