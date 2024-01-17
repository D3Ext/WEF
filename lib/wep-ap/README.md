# How to create a WEP access point

In order to test WEP attacks, I decided to create a little guide with required commands and needed config files.

If you want to test WEP attacks with your own fake WEP AP, you must know that you should split your network card into 2 differents, one to host the AP and other to test this attacks using monitor mode while the AP is running.

## How to split interface

To check if your network adapter supports VIF (Virtual Interfaces) run this command, if it returns output then it does:

```sh
iw list | grep "Supported interface modes" -A 8 | grep "AP/VLAN"
```

***If you are not going to use the same adapter for both purposes, then you don't need to do that so skip next steps too***

Just ensure to replace "wlan0" with your interface name

```sh
interface="wlan0"
rand_mac="f2:11:56:8c:1a:68"

ip link set "$interface" down
iw "$interface" set monitor control
ip link set "$interface" up

iw "$interface" interface add "mon${interface}" type monitor addr ${rand_mac}
```

After that you should have a new interface named as "monwlan0" or "mon" followed by whatever your interfaces is called

If you want to revert this changes execute this commands:

```sh
iw "mon${interface}" del

ifconfig "$interface" down
iwconfig "$interface" mode managed
ifconfig "$interface" up
```

## Launching AP

All we need is ***hostapd-wpe*** and ***dnsmasq***, make proper changes on [hostapd.conf](https://github.com/D3Ext/WEF/blob/main/lib/wep-ap/hostapd.conf) and [dnsmasq.conf](https://github.com/D3Ext/WEF/blob/main/lib/wep-ap/dnsmasq.conf) in order to make it work for you

```sh
hostapd-wpe hostapd.conf
```

<img src="https://raw.githubusercontent.com/D3Ext/WEF/main/images/wep-ap.png">

```sh
dnsmasq -C dnsmasq.conf
```

# References

```
https://stackoverflow.com/questions/41226380/hostapd-configuration-for-wep-network
http://www.netprojnetworks.com/hostapd-wep-config/
https://medium.com/@rueppricha/how-to-configure-a-raspberry-pi-hostapd-router-to-use-wep-encryption-d3e4a300ef99
https://github.com/NuclearPhoenixx/RouteryPi
https://github.com/OpenSecurityResearch/hostapd-wpe
```



