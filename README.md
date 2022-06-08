
-------------------------------------------------

# 📡 WiFi Exploitation Framework 📡

A fully offensive framework to the 802.11 networks and protocol with different types of attacks for WPA and WEP, automated hash cracking and much more.

- I recommend you my alfa adapter: **Alfa AWUS036ACM**, which works really great with both, 2.4 and 5 Ghz

Tested and supported in **Kali Linux**, **Parrot OS**, **Arch Linux** and **Ubuntu**

*\*However it's not finished and may have issues, try it at your own risk.\**

## ⭕ SUPPORTED ATTACKS:

- Deauthentication Attack
- Authentication Attack
- Beacon Flood Attack
- PKMID Attack
- EvilTwin Attack 
- Passive/Stealthy Attack
- Pixie Dust Attack
- Null Pin Attack
- Chopchop Attack
- Replay Attack
- Michael Exploitation Attack
- Caffe-Latte Attack

## ⭕ FEATURES:

:ballot_box_with_check: Log generator

:ballot_box_with_check: WPA/WPA2, WPS and WEP Attacks

:ballot_box_with_check: Handshake Cracking

:ballot_box_with_check: Multiple Templates for EvilTwin Attack

:ballot_box_with_check: Check monitor mode

:ballot_box_with_check: 2Ghz and 5Ghz Attacks

:ballot_box_with_check: Custom wordlist selector

:ballot_box_with_check: Auto detect requirements

:black_square_button: Bluetooth Support (Jamming, Writing, Reading)

## ⭕ REQUIREMENTS:
You need a few tools, but don't worry because the framework detect your OS and install the dependencies if you don't have them:
> Don't install them manually, WEF take care of that

    aircrack-ng
    reaver
    mdk4
    macchanger
    hashcat
    xterm
    hcxtools
    python3
    btlejack
    crackle
    php
    hostadp
    dnsmasq

## ⭕ INSTALLATION:

> Run as root
 
    git clone https://github.com/D3Ext/WEF
    cd WEF
    bash setup.sh

## ⭕ DEMO:

> Demo on a Parrot OS with Kitty terminal
<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

### ⚪ Created by D3ext

> Extra

**If you are using bspwm, you can add this line to your bspwmrc for launching the *xterm* windows always beeing in floating mode** (for a prettier design)

    bspc rule -a XTerm state=floating
    
**If you consider this project has been useful, I would really appreciate supporting me by giving this repo a star or buying me a coffee.**

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/d3ext)

Copyright © 2022, *D3Ext*
