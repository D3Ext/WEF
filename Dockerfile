FROM kalilinux/kali-rolling:latest

# update packages and install main requirements
RUN apt-get update && apt-get install -y git iproute2 iw macchanger aircrack-ng mdk4 xterm gawk sed jq pciutils bsdmainutils curl procps

# set work directory
WORKDIR /app

# clone WEF repository
RUN git clone https://github.com/D3Ext/WEF

# change working directory to repository path
WORKDIR /app/WEF

# execute installer to install WEF
RUN bash wef

WORKDIR /opt/wef

