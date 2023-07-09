# Scripts

In this directory you can find a set of bash scripts with different purposes most of them are mine but other like `apd_launchpad.py` not. They aren't used by the main tool, anyway you can do whatever you want with them:

- ***deauth.sh***

Script used to deauth all clients from AP using Aireplay-ng deauth mode (-0)

- ***wids_confusion.sh***

Script to perform WIDS confusion attack via mdk4

- ***create_vif.sh***

Create a virtual interface and enable monitor mode on interface (revert this with revert_vif.sh)

- ***restore_vif.sh***

Restore previous VIF changes and set interface to managed mode (done with create_vif.sh)

- ***scan_wifis.sh***

Scan nearby APs on selected band with timeout

- ***gen_hostapd_conf.sh***

Script to easily generate hostapd config files

- ***apd_launchpad.py***

Python script to generate hostapd config files for Wifi Enterprise with its certificates, keys and other required files. Useful for EvilTwin attacks against Enterprise networks. Taken from [here](https://github.com/WJDigby/apd_launchpad)






