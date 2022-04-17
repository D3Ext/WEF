#!/bin/bash

echo -e ""
mkdir /opt/WEF
mkdir /opt/WEF/main
mdkir /opt/WEF/main/img
mkdir /opt/WEF/main/modules
mkdir /opt/WEF/main/wordlists
mdkir /opt/WEF/main/captures

wget "https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz" -o /opt/WEF/main/wordlists/rockyou.txt.gz
gunzip /opt/WEF/main/wordlists/rockyou.txt.gz
wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt" -o /opt/WEF/main/wordlists/wordlists/probable-v2-wpa-top4800.txt
wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top10000.txt" -o /opt/WEF/main/wordlists/darkweb2017-top10000.txt
# wget "kaonashi" -o /opt/WEF/main/wordlists/
wget "https://raw.githubusercontent.com/LionSec/xerosploit/master/tools/bettercap/modules/replace_images.rb" -o /opt/WEF/main/modules/replace_images.rb
wget "WEF.sh" -o /opt/WEF/WEF
chmod +x /opt/WEF/WEF
wget "WEF.sh" -o /usr/bin/WEF &>/dev/null
chmod +x /usr/bin/WEF
