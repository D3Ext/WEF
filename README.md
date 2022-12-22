
# 📡 WiFi Exploitation Framework 📡

A fully offensive framework to the 802.11 networks and protocols with different types of attacks for WPA/WPA2 and WEP, automated hash cracking, and much more.

Tested and supported in **Kali Linux**, **Parrot OS** and **Arch Linux**. If you have any error please open an issue (if you want to write it in spanish you can do it). If you have any doubt, please contact me via Discord ***D3Ext#5965***

If you don't know how wifi hacking works you can read my free course [here](https://d3ext.github.io/posts/Curso/), it's written in Spanish and I explain things from 0

*\*However it's not finished and may have issues, but if you have one, feel free to contact me and I'll try to fix it.\**

- I recommend you my alfa adapter: **Alfa AWUS036ACM**, which works really great with both, 2.4 and 5 Ghz

## ⭕ SUPPORTED ATTACKS

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

- GPS Spoofing with HackRF (not finished)

## ⭕ FEATURES

:ballot_box_with_check: Descriptives attack logs

:ballot_box_with_check: WPA/WPA2, WPS and WEP Attacks

:ballot_box_with_check: Auto handshake cracking

:ballot_box_with_check: Multiple templates for EvilTwin attack (even custom)

:ballot_box_with_check: Check monitor mode and its status

:ballot_box_with_check: 2.4Ghz and 5Ghz attacks

:ballot_box_with_check: Custom wordlist selector

:ballot_box_with_check: Auto detect requirements

## ⭕ USAGE

> Common usage of the framework

```sh
wef -i wlan0 # Your interface name might be different
```

or

```sh
wef --interface wlan0
```

Once the application is running, type `help` to view more functions and useful info.

## ⭕ REQUIREMENTS

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
    php
    hostadp
    dnsmasq

## ⭕ INSTALLATION

Checkout the [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) where I have more info about the program

## ⭕ UNINSTALLATION

Checkout the [Wiki](https://github.com/D3Ext/WEF/wiki/Uninstallation)

## ⭕ DEMO

> Demo on a Parrot OS with Kitty terminal

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

### ⚪ Special thanks to [ultrazar](https://github.com/ultrazar) who helped me a lot <3

### ⚪ Extra

**If you are using bspwm, you can add this line to your bspwmrc for launching the *xterm* windows which is always in floating mode** (for a prettier design)

    bspc rule -a XTerm state=floating

**If you consider this project useful, I would really appreciate supporting me by giving this repo a star or buying me a coffee.**

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/d3ext)

Copyright © 2022, *D3Ext*
