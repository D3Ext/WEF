
# 📡 WiFi Exploitation Framework 📡

A fully offensive framework to the 802.11 networks and protocols with different types of attacks for WPA/WPA2 and WEP, automated hash cracking, bluetooth hacking and much more.

Tested and supported in **Kali Linux**, **Parrot OS** and **Arch Linux** . If you have any error please open an issue (if you want to write it in spanish you can do it). If you have any doubt, please contact me via Instagram (@D3Ext) or Twitter (@D3Ext)

*\*However it's not finished and may have issues, but if you have one, feel free to contact me and I'll try to fix it.\**

- I recommend you my alfa adapter: **Alfa AWUS036ACM**, which works really great with both, 2.4 and 5 Ghz

## ⭕ SUPPORTED ATTACKS:

- Deauthentication Attack

- Authentication Attack

- Beacon Flood Attack

- PMKID Attack

- EvilTwin Attack 

- Passive/Stealthy Attack

- Pixie Dust Attack

- Null Pin Attack

- WEP Protocol Attacks

- Michael Exploitation Attack

- Jamming, Reading and Writing bluetooth connections (Not finished)

- GPS Spoofing with HackRF 

## ⭕ FEATURES:

:ballot_box_with_check: Descriptives attack logs

:ballot_box_with_check: WPA/WPA2, WPS and WEP Attacks

:ballot_box_with_check: Auto handshake cracking

:ballot_box_with_check: Multiple templates for EvilTwin attack

:ballot_box_with_check: Check monitor mode and its status

:ballot_box_with_check: 2.4Ghz and 5Ghz attacks

:ballot_box_with_check: Custom wordlist selector

:ballot_box_with_check: Auto detect requirements


## ⭕ USAGE:
> Common usage of the framework

```sh
wef -i wlan0 # Your interface name might be different
```
or
```sh
wef --interface wlan0
```

Once the application is running, type `help` to view more functions and useful info.

However I'll do a post on my blog about WEF and wifi hacking from **zero to hero**

## ⭕ REQUIREMENTS:
> Don't install them manually, WEF takes care of that if you don't already have them 

    aircrack-ng
    reaver
    mdk4
    macchanger
    hashcat
    xterm
    hcxtools
    pixiewps
    python3
    btlejack
    crackle
    php
    hostadp
    dnsmasq

## ⭕ INSTALLATION:

Checkout the [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) where I have more info about the program

## ⭕ UNINSTALLATION:

Checkout the [Wiki](https://github.com/D3Ext/WEF/wiki/Uninstallation)

## ⭕ DEMO:

> Demo on a Parrot OS with Kitty terminal

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">


### ⚪ Specials thanks to [ultrazar](https://github.com/ultrazar) who helped me a lot <3

### ⚪ Extra

**If you are using bspwm, you can add this line to your bspwmrc for launching the *xterm* windows always beeing in floating mode** (for a prettier design)

    bspc rule -a XTerm state=floating
    
**If you consider this project has been useful, I would really appreciate supporting me by giving this repo a star or buying me a coffee.**

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/d3ext)

Copyright © 2022, *D3Ext*
