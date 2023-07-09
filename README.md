<p align="center">
  <h1 align="center">WiFi Exploitation Framework</h1>
</p>

<p align="center">
  <a href="#attacks">Attacks</a> •
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#uninstallation">Uninstallation</a> •
  <a href="#disclaimer">Disclaimer</a>
</p></br>

<p align="center">
  <a href="SPANISH.md">Readme in spanish</a>
</p>

## Introduction

This project started about a year ago as a personal tool to easily audit networks without writing long commands, nor setting all values one by one and to automate the whole processes. After some time the repository obtained a bunch of stars so I decided to improve it.

It's a fully offensive framework to audit 802.11 networks and protocols with different types of attacks for WPA/WPA2 and WEP, automated hash cracking, and much more. Tested and supported in **Kali Linux**, **Parrot OS** and **Arch Linux**.

If you have any error please open an issue (if you want to write it in spanish you can do it). If you have any doubt contact me via Discord, my username is ***d3ext***

If you don't know how wifi hacking works you can read my free course [here](https://d3ext.github.io/posts/Curso/), it's written in Spanish and I explain things from zero

I recommend you my network adapter ***Alfa AWUS036ACM*** as it works with both ***2.4Ghz and 5Ghz*** and it also supports ***VIF*** (Virtual Interface). See [here](https://github.com/v1s1t0r1sh3r3/airgeddon/wiki/Cards%20and%20Chipsets) for more info and to choose a good antenna.

## Attacks

- Deauthentication attack

- Authentication attack

- Beacon Flood attack

- PMKID attack

- EvilTwin attack

- Passive attack (capture WPA handshakes)

- Pixie Dust attack

- Null Pin attack

- Michael Shutdown Exploitation attack

- WIDS Confusion attack

- WEP Protocol attacks

You have an explanation of the different attacks [here](https://github.com/D3Ext/WEF/wiki/Attacks) on Wiki's repo

## Features

:ballot_box_with_check: WPA/WPA2, WPS and WEP Attacks

:ballot_box_with_check: Automatic handshake capture and cracking

:ballot_box_with_check: Multiple templates for EvilTwin attack (different languages)

:ballot_box_with_check: Enable monitor mode and view interface info (frequencies, chipset, MAC...)

:ballot_box_with_check: 2.4Ghz and 5Ghz supported

:ballot_box_with_check: Informative attack logs (just done user side)

:ballot_box_with_check: Custom wordlist selector when cracking

:ballot_box_with_check: English and spanish supported

## Usage

> Common usage of the framework

```sh
wef -i wlan0 # Your interface name might be different
```

or

```sh
wef --interface wlan0
```

> Set the tool language to spanish

```sh
wef -i wlan0 -s
```

> Enable verbose to see more information

```sh
wef -i wlan0 -v
```

> Help Panel

```
 __      _____ ___
 \ \    / / __| __|
  \ \/\/ /| _|| _|
   \_/\_/ |___|_|

[WEF] Wi-Fi Exploitation Framework 1.2

[*] Interfaces:
	wlan0

Required parameters:
	-i, --interface) 	The name of your network card interface in managed mode

Optional parameters:
	-v, --verbose) 		Show more info during the attacks
	-h, --help) 		Show this help panel
	--version) 		    Print the version and exit
	-s) 			    Set tool language to spanish
```

See [here](https://github.com/D3Ext/WEF/wiki/Usage-&-Tips) for more information about how to use the tool and other related topics

## Requirements

WEF needs some requirements to work correctly, but don't worry because they will be installed automatically during installation if they aren't installed yet on your system.

    aircrack-ng
    reaver
    mdk4
    macchanger
    hashcat
    xterm
    hcxtools
    hcxdumptool
    pixiewps
    lighttpd
    dhcp
    hostapd
    hostapd-wpe
    dnsmasq

## Installation

Take a look at the [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) where I have more info about the program

## Uninstallation

Visit the [Wiki](https://github.com/D3Ext/WEF/wiki/Uninstallation)

## Demo

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo2.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo3.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo4.png">

## TODO

- EvilTwin attack for Enterprise networks

- More options to crack handshakes

- Better way to scan APs

- General improvements

## Contributing

See [CONTRIBUTING.md](https://github.com/D3Ext/WEF/blob/main/CONTRIBUTING.md)

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

Creator isn't in charge of any and has no responsibility for any kind of:

- Illegal use of the project.
- Legal infringement by third parties and users.
- Malicious acts, capable of causing damage to third parties, promoted by the user through this software.

## License

This project is under MIT license

Copyright © 2023, *D3Ext*



