#!/bin/bash

var=$(cat /home/metallicstream/oldIp.txt)
var4=$(cat /home/metallicstream/oldvzwIp.txt)
var5=$(cat /home/metallicstream/presentvzwIp.txt)
var1=$(cat /home/metallicstream/presentIp.txt)
#newIP=$newIp
set -e
sudo cat /var/lib/bind/xtremville.net.hosts | sudo tee /home/metallicstream/DNS.txt
sudo chown metallicstream:metallicstream /home/metallicstream/DNS.txt
var2=$(grep $var /home/metallicstream/oldIp.txt)
var6=$(grep $var4 /home/metallicstream/oldvzwIp.txt)
var7=$(grep $var5 /home/metallicstream/presentvzwIp.txt)
var3=$(grep $var1 /home/metallicstream/presentIp.txt)
sudo sed -i "s/$var2/$var3/" /home/metallicstream/DNS.txt
sudo sed -i "s/$var4/$var5/" /home/metallicstream/DNS.txt
sudo cp /home/metallicstream/DNS.txt /var/lib/bind/xtremville.net.hosts
sudo cp /home/metallicstream/DNS.txt /home/metallicstream/ipProccess/xtremville.net.hosts.txt
sudo cat /home/metallicstream/DNS.txt
#sudo rm /home/metallicstream/DNS.txt

