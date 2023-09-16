#!/bin/bash

nmcli con down id "in_lan"
nmcli con down id "the0_lan"
nmcli con down id "the1_lan"
nmcli con down id "the2_lan"
nmcli con down id "in_internet"
nmcli con down id "XtremSpot"
#nmcli connection add con-name "in_lan" type ethernet ifname enp10s0f0 ipv4.method auto ipv6.method auto
#nmcli connection add con-name "the0_lan" type ethernet ifname enp10s0f1 ipv4.method shared ip4 10.42.0.1 ipv6.method shared ip6 fe90::6d2e:60cf:164:630c
#nmcli connection add con-name "the1_lan" type ethernet ifname enp5s0 ipv4.method shared ip4 10.42.1.1 ipv6.method shared ip6 fe80::6d2e:60cf:164:630c
#nmcli connection add con-name "the2_lan" type ethernet ifname enp6s0 ipv4.method shared ip4 10.42.2.1 ipv6.method shared ip6 fe70::6d2e:60cf:164:630c
#nmcli connection add con-name "the_internet" type ethernet ifname enp8s0 ipv4.method auto ipv6.method auto
#nmcli con mod the0_lan ipv4.dns "10.42.0.1"
#nmcli con mod the1_lan ipv4.dns "10.42.1.1"
#nmcli con mod the2_lan ipv4.dns "10.42.2.1"
nmcli con up 1a7e9545-5987-4d24-be44-de581b693547
nmcli con up c9c41ae4-8f4b-4492-8783-75cc0c0b0ca4
nmcli con up f022eb3f-45ea-4130-aaa4-d0b7474f8cb6
nmcli con up 1268e486-cb85-443c-aa32-db8a2189133c
nmcli con up b8d12f89-481f-48f4-a053-81c544ad5afc
nmcli con up 38692955-e59f-4a58-a43d-982e7b4bf2ff
#nmcli con add type wifi ifname wlp9s0 con-name XtremSpot autoconnect yes ssid XTREMSPOT
nmcli con modify 38692955-e59f-4a58-a43d-982e7b4bf2ff 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared ip4 10.42.3.1 ipv6.method shared ip6 fe60::6d2e:60cf:164:630c
#nmcli con mod 38692955-e59f-4a58-a43d-982e7b4bf2ff ipv4.dns "10.42.3.1"
nmcli con modify 38692955-e59f-4a58-a43d-982e7b4bf2ff wifi-sec.key-mgmt wpa-psk
nmcli con modify 38692955-e59f-4a58-a43d-982e7b4bf2ff wifi-sec.psk "Alpha444@"
#systemctl status isc-dhcp-server.service
#journalctl -xeu isc-dhcp-server.service
/etc/init.d/isc-dhcp-server restart
exit