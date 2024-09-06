<p align="center">
  <h1 align="center">WEF</h1>
  <h4 align="center">WiFi Exploitation Framework</h4>
  <h6 align="center">Hecho con 💙 por D3Ext</h6>
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
  <a href="#introduccion">Introducción</a> •
  <a href="#ataques">Ataques</a> •
  <a href="#funciones">Funciones</a> •
  <a href="#instalación">Instalación</a> •
  <a href="#requisitos">Requisitos</a>
</p>

<div align="center">
  <img src="images/wef.webp" alt="WEF" width=23% height=50%>
</div>

## Introducción

Este proyecto comenzó alrededor de 2021 como una herramienta personal para auditar redes fácilmente sin escribir comandos largos, ni configurar todos los valores uno a uno además de automatizar todo el proceso. Esta no es una herramienta profesional, este proyecto fue creado para aprender acerca de la seguridad wireless. Esto un framework ofensivo para auditar redes wifi con diferentes tipos de ataques WPA/WPA2, WPS y WEP, cracking de hashes automatizado y mucho más.

Si encuentras algún error, abre un issue en el repositorio (puedes escribirlo en español o inglés, como prefieras). Si tienes alguna duda también puedes contactar conmigo por Discord, mi usuario es ***d3ext***

## Ataques

- Ataque de deautenticación
- Ataque de confusión WIDS
- Ataque de autenticación
- Ataque Beacon Flood
- Ataque TKIP (Michael Shutdown Exploitation)
- Ataque Pixie Dust
- Ataque de pin nulo 
- Ataque de fuerza bruta de PIN
- Ataque ARP Replay
- Ataque HIRTE
- Ataque Caffe Latte
- Ataque de falsa autenticación
- Ataque de captura de handshake WPA/WPA2 (de forma pasiva)
- Ataque PMKID
- Ataque Evil Twin

Los diferentes ataques están explicados [aquí](https://github.com/D3Ext/WEF/wiki/Attacks) en la Wiki del repositorio

## Funciones

:ballot_box_with_check: Ataques WPA/WPA2, WPS y WEP

:ballot_box_with_check: Captura y crackeo automático de handshakes

:ballot_box_with_check: Multiples plantillas para el ataque EvilTwin (en diferentes idiomas)

:ballot_box_with_check: Activar/desactivar el modo monitor y randomizar la dirección MAC

:ballot_box_with_check: 2.4 GHz y 5 GHz soportados

:ballot_box_with_check: Logs informativos sobre los ataques (solo se registra del lado del usuario)

:ballot_box_with_check: Diccionarios personalizados al crackear handshakes

:ballot_box_with_check: Inglés y español soportados

Y mucho más

## Instalación

> Como root
```sh
git clone https://github.com/D3Ext/WEF
cd WEF
bash wef
```

Echa un ojo a la [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) donde hay más información sobre la instalación

## Desinstalación

```sh
rm -rf /usr/share/wef \
  /usr/bin/wef
```

## Uso

> Uso habitual del framework
```sh
wef -i wlan0 # El nombre de la interfaz puede ser diferente
```

> Panel de ayuda
```
 __      _____ ___
 \ \    / / __| __|
  \ \/\/ /| _|| _|
   \_/\_/ |___|_|

[WEF] WiFi Exploitation Framework 1.4

[*] Interfaces:
    wlan0
    ens33

Required parameters:
    -i, --interface)    The name of your network adapter interface in managed mode

Optional parameters:
    -h, --help)         Show this help panel
    --version)          Print the version and exit
```

Mira [aquí](https://github.com/D3Ext/WEF/wiki/Usage-&-Tips) para más información sobre como usar la herramienta y otros temas relacionados

## Demo

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo2.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo3.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/help-panel.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/randomize-mac.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/info.png">

## TODO

- ~~Modo Pwnagotchi~~
- Añadir logo a las plantillas del ataque EvilTwin automaticamente basado en el vendor
- Comprobar la compatibilidad con otros OS
- ~~Ataque KARMA~~
- Probar en profundidad las funcionalidades implementadas
- ~~Más mejoras generales~~
- ~~Más lenguajes añadidos a las plantillas de Evil Twin~~

## Contribuir

Mira [CONTRIBUTING.md](https://github.com/D3Ext/WEF/blob/main/CONTRIBUTING.md)

## Changelog

Mira [CHANGELOG.md](https://github.com/D3Ext/WEF/blob/main/CHANGELOG.md)

## Creditos

Gracias a [ultrazar](https://github.com/ultrazar) y a [ErKbModifier](https://github.com/ErKbModifier) por ayudarme con la herramienta <3

## Referencias

```
https://github.com/aircrack-ng/aircrack-ng
https://github.com/aircrack-ng/mdk4
https://github.com/v1s1t0r1sh3r3/airgeddon
https://github.com/FluxionNetwork/fluxion
https://github.com/P0cL4bs/wifipumpkin3
https://github.com/s0lst1c3/eaphammer
https://github.com/derv82/wifite2
https://github.com/wifiphisher/wifiphisher
https://github.com/ZerBea/hcxtools
https://github.com/ZerBea/hcxdumptool
https://github.com/Tylous/SniffAir
https://github.com/evilsocket/pwnagotchi
https://github.com/koutto/pi-pwnbox-rogueap
https://github.com/koutto/pi-pwnbox-rogueap/wiki/01.-WiFi-Basics
```

## Disclaimer

El creador no se hace cargo de:

- Uso ilegal del proyecto.
- Infracción legal por parte de terceros y usuarios.
- Acto maliciosos, capaz de causar daños a terceros, promovido por el usuario a través de este software.

## Licencia

Este proyecto está bajo licencia MIT

Copyright © 2024, *D3Ext*

