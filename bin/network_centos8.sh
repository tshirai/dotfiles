#! /bin/bash
addr=192.168.56.108/24
sudo nmcli connection modify enp0s8 ipv4.method manual ipv4.addresses ${addr} connection.autoconnect yes
