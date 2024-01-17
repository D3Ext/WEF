<p align="center">
  <h1 align="center">WEF</h1>
  <h4 align="center">Wi-Fi Exploitation Framework</h4>
  <h6 align="center">Coded with 💙 by D3Ext</h6>
</p>

<p align="center">

  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/license-MIT-_red.svg">
  </a>

  <a href="https://github.com/D3Ext/D3Ext/blob/main/CHANGELOG.md">
    <img src="https://img.shields.io/badge/maintained%3F-yes-brightgreen.svg">
  </a>

  <a href="https://github.com/D3Ext/WEF/issues">
    <img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat">
  </a>

</p>

<p align="center">
  <a href="#introduction">Introduction</a> •
  <a href="#attacks">Attacks</a> •
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#requirements">Requirements</a>
</p></br>

<p align="center">
  <a href="SPANISH.md">Readme in spanish</a>
</p>

## Introduction

This project started over 2021 as a personal tool to easily audit networks without writing long commands nor setting all values one by one and to automate the whole processes. This is not a professional tool, I created this project to learn and for testing purposes. After some time the repository obtained a bunch of stars so I decided to improve it. It's a fully offensive framework to audit wi-fi networks with different types of attacks for WPA/WPA2, WPS and WEP, automated hash cracking, and much more.

If you have any error please open an issue (if you want to write it in spanish you can do it). If you have any doubt contact me via Discord, my username is ***d3ext***

## Attacks

- Deauthentication attack
- WIDS Confusion attack
- Authentication attack
- Beacon Flood attack
- TKIP attack (Michael Shutdown Exploitation)
- Pixie Dust attack
- Null Pin attack
- PIN Bruteforce attack
- ARP Replay attack
- HIRTE attack
- Caffe Latte attack
- Fake Authentication attack
- WPA/WPA2 handshake capture attack
- PMKID attack
- EvilTwin attack

You have an explanation of the different attacks [here](https://github.com/D3Ext/WEF/wiki/Attacks) on Wiki's repo

## Features

:ballot_box_with_check: WPA/WPA2, WPS and WEP Attacks

:ballot_box_with_check: Automatic handshake capture and cracking

:ballot_box_with_check: Multiple templates for EvilTwin attack (different languages)

:ballot_box_with_check: Enable/disable monitor mode and view interface info (frequencies, chipset, MAC...)

:ballot_box_with_check: 2.4 GHz and 5 GHz supported

:ballot_box_with_check: Informative attack logs (just done user side)

:ballot_box_with_check: Custom wordlist selector when cracking

:ballot_box_with_check: English and spanish supported

And much more

## Installation

> As root
```sh
git clone https://github.com/D3Ext/WEF
cd WEF
bash wef
```

Take a look at the [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) where I have more info about the installation

## Uninstallation

Simply execute this:

```sh
rm -rf /opt/wef \
  /usr/bin/wef
```

## Usage

> Common usage of the framework
```sh
wef -i wlan0 # Your interface name might be different
```

> Help panel
```
 __      _____ ___
 \ \    / / __| __|
  \ \/\/ /| _|| _|
   \_/\_/ |___|_|

[WEF] Wi-Fi Exploitation Framework 1.3

[*] Interfaces:
    docker0
    ens33
    lo

Required parameters:
    -i, --interface)    The name of your network adapter interface in managed mode

Optional parameters:
    -h, --help)         Show this help panel
    --version)          Print the version and exit
```

See [here](https://github.com/D3Ext/WEF/wiki/Usage-&-Tips) for more information about how to use the tool and other related topics

## Demo

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo2.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo3.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/help-panel.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/randomize-mac.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/info.png">

## TODO

- ~~EvilTwin attack for Enterprise networks~~
- ~~More options to crack handshakes~~
- ~~Better way to scan APs~~
- ~~Identify found devices vendors by their MAC addresses~~
- ~~Config file improved with more settings~~
- ~~General improvements~~
- Test compatibility with others OS
- Support WPA3 dictionary attack
- MANA and KARMA attack
- In-depth testing of implemented features
- More general improvement

## Contributing

See [CONTRIBUTING.md](https://github.com/D3Ext/WEF/blob/main/CONTRIBUTING.md)

## Changelog

See [CHANGELOG.md](https://github.com/D3Ext/WEF/blob/main/CHANGELOG.md)

## Credits

Thanks to [ultrazar](https://github.com/ultrazar) and [ErKbModifier](https://github.com/ErKbModifier), they helped me a lot <3

## References

```
https://github.com/v1s1t0r1sh3r3/airgeddon
https://github.com/FluxionNetwork/fluxion
https://github.com/P0cL4bs/wifipumpkin3
https://github.com/s0lst1c3/eaphammer
https://github.com/derv82/wifite2
https://github.com/aircrack-ng/mdk4
https://github.com/aircrack-ng/aircrack-ng
https://github.com/wifiphisher/wifiphisher
https://github.com/ZerBea/hcxtools
https://github.com/ZerBea/hcxdumptool
https://github.com/Tylous/SniffAir
https://github.com/koutto/pi-pwnbox-rogueap
https://github.com/koutto/pi-pwnbox-rogueap/wiki/01.-WiFi-Basics
```

## Disclaimer

Creator has no responsibility for any kind of:

- Illegal use of the project.
- Law infringement by third parties and users.
- Malicious act, capable of causing damage to third parties, promoted by the user through this software.

## License

This project is under MIT license

Copyright © 2024, *D3Ext*



