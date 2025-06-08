<div align="center">
  <img src="images/logo.png" alt="WEF" width=23% height=50%>
</div>

<p align="center">
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
  <a href="#ataques-soportados">Ataques</a> •
  <a href="#funciones">Funciones</a> •
  <a href="#instalación">Instalación</a> •
  <a href="#requisitos">Requisitos</a>
</p>

## Introducción

Esta herramienta está diseñada para que los investigadores de seguridad y los penetration testers analicen y exploten las vulnerabilidades de las redes Wi-Fi. Proporciona una interfaz intuitiva con una amplia gama de técnicas de ataque automatizadas y manuales para probar la seguridad WPA/WPA2, WPS y WEP. Con soporte para redes de 2,4 GHz y 5 GHz, registro detallado y opciones de ataque personalizables, ofrece flexibilidad para diferentes escenarios de prueba. No se trata de una herramienta profesional.

Si encuentras algún error, abre un issue en el repositorio (puedes escribirlo en español o inglés, como prefieras).

## Ataques soportados

- DoS:
    - Ataque de deautenticación
    - Ataque de confusión WIDS
    - Ataque de autenticación
    - Ataque Beacon Flood
    - Ataque TKIP (Michael Shutdown Exploitation)
- WPS:
    - Ataque Pixie Dust
    - Ataque de fuerza bruta de PIN
    - Ataque de pin nulo
- WEP:
    - Ataque ARP Replay
    - Ataque HIRTE
    - Ataque Caffe Latte
    - Ataque de falsa autenticación
- Handshake:
    - Captura de handshake WPA (sin deauth)
    - Ataque PMKID (sin clientes)
- Rogue-AP:
    - EvilTwin:
        - Modo KARMA
        - WPA Enterprise
        - Deautenticación soportada
- Otros ataques:
    - Modo de ataque automatico (Auto PWN)
    - Ataque WPA3 con diccionario

Todos los ataques mencionados arriba están explicados [aquí](https://github.com/D3Ext/WEF/wiki/Attacks) en la Wiki de este repositorio

## Funciones

Estas son algunas de las funciones mas destacadas:

:ballot_box_with_check: Ataques WPA, WPS, WEP, Rogue-AP y de Handshake

:ballot_box_with_check: Modo de ataque automático en función de las características del AP

:ballot_box_with_check: Captura y cracking automático de handshakes

:ballot_box_with_check: Cracking de handshakes online y offline

:ballot_box_with_check: Plantilla simple de login para el ataque Evil Twin (en diferentes idiomas)

:ballot_box_with_check: Activar/desactivar el modo monitor y ver información sobre la interfaz de red (frecuencias, chipset, dirección MAC...)

:ballot_box_with_check: 2.4 GHz y 5 GHz soportados

:ballot_box_with_check: Reportes informativos sobre los ataques en formato HTML

:ballot_box_with_check: Inglés y español soportados

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

> Uso habitual del framework (el nombre de la interfaz puede ser diferente)
```sh
wef -i wlan0
```

> Panel de ayuda
```
 __      _____ ___
 \ \    / / __| __|
  \ \/\/ /| _|| _|
   \_/\_/ |___|_|

[WEF] WiFi Exploitation Framework 1.5

Interfaces:
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

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo4.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo5.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/help-panel.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/randomize-mac.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/info.png">

## TODO

- ~~Online handshake cracking (WPA-SEC)~~
- ~~Ataque WPA3 con diccionario~~
- ~~Modificar el dominio regulatorio para cambiar el txpower~~
- ~~Mas idiomas añadidos a las plantillas del ataque Evil Twin~~
- ~~Randomiza la direccion MAC automaticamente durante el inicio~~
- ~~Mejoras generales y arreglos menores~~
- ~~Errores solucionados~~
- ~~Modo automatico de exploit~~
- ~~Los escaneos de APs ahora muestran si WPS está activado~~
- ~~Soporte para autocompletar las rutas de los archivos~~
- ~~Mejor logging por pantalla~~
- ~~Mejor redibilidad del codigo (codigo optimizado)~~
- ~~Añadir logo a las plantillas del ataque EvilTwin automaticamente basado en el vendor~~
- ~~Los vendors de las direcciones MAC han sido actualizados y optimizados~~
- Comprobar la compatibilidad con otros OS
- ~~Probar en profundidad las funcionalidades implementadas~~

## Contribuir

Mira [CONTRIBUTING.md](https://github.com/D3Ext/WEF/blob/main/CONTRIBUTING.md)

## Changelog

Mira [CHANGELOG.md](https://github.com/D3Ext/WEF/blob/main/CHANGELOG.md)

## Creditos

Gracias a [ultrazar](https://github.com/ultrazar) y a [ErKbModifier](https://github.com/ErKbModifier)

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

El creador no se hace cargo de ningún uso ilegal del proyecto

## Licencia

Este proyecto está bajo licencia MIT

Copyright © 2025, *D3Ext*

