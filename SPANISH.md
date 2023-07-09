<p align="center">
  <h1 align="center">WiFi Exploitation Framework</h1>
</p>

<p align="center">
  <a href="#ataques">Ataques</a> •
  <a href="#funciones">Funciones</a> •
  <a href="#instalacion">Instalación</a> •
  <a href="#desinstalacion">Desinstalación</a> •
  <a href="#disclaimer">Disclaimer</a> •
</p>

## Introduccion

Este proyecto comenzó hace un año como una herramienta personal para auditar redes fácilmente sin escribir comandos largos, ni configurar todos los valores uno a uno ademas de automatizar todo el proceso. Después de algún tiempo el repositorio obtuvo muchas estrellas así que decidí mejorarlo.

Es un framework ofensivo para auditar las redes y protocolos 802.11 con diferentes tipos de ataques WPA/WPA2 y WEP, cracking de hashes automatizado, y mucho más. Probado y mantenido para ***Kali Linux***, ***Parrot OS*** and ***ArchLinux***.

Si tienes algun error abre un issue en el repositorio (puedes escribirlo en español o ingles, como prefieras). Si tienes alguna duda también puedes contactar conmigo por Discord, mi usuario es ***d3ext***

Si no sabes como funciona el hacking wifi te recomiendo leer mi curso [aqui](https://d3ext.github.io/posts/Curso), es totalmente gratis, explico las cosas desde cero y está escrito en español.

Te recomiendo mi adaptador de red ***Alfa AWUS036ACM*** ya que soporta 2.4Ghz y 5Ghz además es compatible con ***VIF*** (Interfaz Virtual). Mira [aqui](https://github.com/v1s1t0r1sh3r3/airgeddon/wiki/Cards%20and%20Chipsets) para mas información y sobre como elegir una buena antena.

## Ataques

- Ataque de Deautenticación

- Ataque de Autenticación

- Ataque Beacon Flood

- Ataque PMKID

- Ataque EvilTwin

- Ataque Pasivo (captura de handshakes WPA)

- Ataque Pixie Dust

- Ataque de Pin nulo

- Ataque Michael Exploitation

- Ataque de Confusión WIDS

- Ataques del protocolo WEP

Tienes una explicación de los diferentes ataques [aqui](https://github.com/D3Ext/WEF/wiki/Attacks) en la Wiki del repositorio

## Funciones

:ballot_box_with_check: Ataques WPA/WPA2, WPS y WEP

:ballot_box_with_check: Captura y crackeo automático de handshakes

:ballot_box_with_check: Multiples plantillas para el ataque EvilTwin (en diferentes idiomas)

:ballot_box_with_check: Habilitar el modo monitor y randomizar la dirección MAC

:ballot_box_with_check: 2.4Ghz y 5Ghz soportados

:ballot_box_with_check: Logs informativos de los ataques (solo se registra del lado del usuario)

:ballot_box_with_check: Diccionarios personalizados al crackear handshakes

:ballot_box_with_check: Inglés y español soportados

## Uso

> Uso habitual del framework

```sh
wef -i wlan0 # El nombre de la interfaz puede ser diferente
```

o también

```sh
wef --interface wlan0
```

> Si quieres usar el framework en español también puedes

```sh
wef -i wlan0 -s
```

> Habilita el verbose para ver mas información

```sh
wef -i wlan0 -v
```

> Panel de ayuda

```
 __      _____ ___
 \ \    / / __| __|
  \ \/\/ /| _|| _|
   \_/\_/ |___|_|

[WEF] Wi-Fi Exploitation Framework 1.2

[*] Interfaces:
	wlan0

Parametros requeridos:
	-i, --interface) 	El nombre de la interfaz de tu tarjeta de red en modo managed

Parametros opcionales:
	-v, --verbose) 		Muestra mas información durante los ataques
	-h, --help) 		Muestra este panel de ayuda
	--version) 		    Imprime por pantalla la versión actual del programa
    -s)                 Cambia el idioma al español
```

Mira [aqui](https://github.com/D3Ext/WEF/wiki/Usage-&-Tips) para mas información sobre como usar la herramienta y otros temas relacionados

## Requisitos

WEF necesita ciertos requisitos para funcionar correctamente, pero no te preocupes porque estos se instalan durante el proceso de instalación en caso de no estar instalados aun

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

## Instalación

Echale un ojo a la [Wiki](https://github.com/D3Ext/WEF/wiki/Installation) donde hay mas información sobre la instalación

## Desinstalación

Visita la [Wiki](https://github.com/D3Ext/WEF/wiki/Uninstallation) para desinstalar WEF rapidamente

## Demo

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo2.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo3.png">

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wef-demo4.png">

## TODO

- Ataque EvilTwin para redes Enterprise

- Mas opciones para crackear handshakes

- Una mejor forma de escanear los APs

- Mejoras generales

## Contribuir

Mira [CONTRIBUTING.md](https://github.com/D3Ext/WEF/blob/main/CONTRIBUTING.md)

## Creditos

Gracias a [ultrazar](https://github.com/ultrazar) y [ErKbModifier](https://github.com/ErKbModifier) por ayudarme con la herramienta <3

## Referencias

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

El creador no se hace cargo de:

- Uso ilegal del proyecto.
- Infracción legal por parte de terceros y usuarios.
- Acto maliciosos, capaz de causar daños a terceros, promovido por el usuario a través de este software.

## Licencia

Este proyecto esta bajo licencia MIT

Copyright © 2023, *D3Ext*


