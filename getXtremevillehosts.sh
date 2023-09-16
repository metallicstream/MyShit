#!/bin/bash
set -e

sudo curl "https://xtremeville.net/xtremeville.net.hosts" | sudo tee /var/lib/bind/xtremeville.net.hosts


sudo nmcli connection add con-name "in_lan" type ethernet ifname enp10s0f0 ipv4.method auto ipv6.method auto