FROM kalilinux/kali-rolling:latest

# update packages and install main requirements
RUN apt-get update && apt-get install -y iproute2 iw macchanger aircrack-ng mdk4 xterm awk sed jq pciutils bsdmainutils curl procps john hashcat hcxtools hcxdumptool reaver pixiewps hostapd hostapd-wpe dnsmasq lighttpd bettercap python3

# set work directory
WORKDIR /app

# clone WEF repository
RUN git clone https://github.com/D3Ext/WEF

# change working directory to repository path
WORKDIR /app/WEF

# execute the installer to install WEF
RUN bash wef


