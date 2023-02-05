<p align="center">
  <h1 align="center">WiFi Exploitation Framework</h1></br>
</p>

<p align="center">
  <a href="#attacks">Attacks</a> •
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#uninstallation">Uninstallation</a> •
  <a href="#disclaimer">Disclaimer</a>
</p>

## Introduction

A fully offensive framework to the 802.11 networks and protocols with different types of attacks for WPA/WPA2 and WEP, automated hash cracking, and much more.

Tested and supported in **Kali Linux**, **Parrot OS** and **Arch Linux**. If you have any error please open an issue (if you want to write it in spanish you can do it). If you have any doubt, please contact me via Discord ***D3Ext#5965***

If you don't know how wifi hacking works you can read my free course [here](https://d3ext.github.io/posts/Curso/), it's written in Spanish and I explain things from 0

- I recommend you my alfa adapter: **Alfa AWUS036ACM**, which works really great with both, 2.4 and 5 Ghz

## Attacks

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

## Features

:ballot_box_with_check: WPA/WPA2, WPS and WEP Attacks

:ballot_box_with_check: Auto handshake capture and cracking

:ballot_box_with_check: Multiple templates for EvilTwin attack (even custom)

:ballot_box_with_check: Check monitor mode and its status

:ballot_box_with_check: 2.4Ghz and 5Ghz attacks

:ballot_box_with_check: Descriptive attack logs (just done user side)

:ballot_box_with_check: Custom wordlist selector

## Usage

> Common usage of the framework

```sh
wef -i wlan0 # Your interface name might be different
```

or

```sh
wef --interface wlan0
```

Once the application is running, type `help` to view more functions and useful info.

## Requirements

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

## Installation

Checkout the [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) where I have more info about the program

## Uninstallation

Checkout the [Wiki](https://github.com/D3Ext/WEF/wiki/Uninstallation)

## Demo

> Demo on a Parrot OS with Kitty Terminal

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

## Special thanks to [ultrazar](https://github.com/ultrazar) who helped me a lot <3

## Support

*If you consider this project useful, I would really appreciate supporting me by giving this repo a star or buying me a coffee.*

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/d3ext)

## Disclaimer

Creator isn't in charge of any and has no responsibility for any kind of:

- Unlawful or illegal use of the project.
- Legal or Law infringement (acted in any country, state, municipality, place) by third parties and users.
- Act against ethical and / or human moral, ethic, and peoples of the world.
- Malicious act, capable of causing damage to third parties, promoted or distributed by third parties or the user through this software.

## License

This project is under MIT license

Copyright © 2023, *D3Ext*



