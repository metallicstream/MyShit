#!/bin/bash
set -e
sudo cat /var/lib/bind/xtremeville.net.hosts | sudo tee /home/metallicstream/ipProccess/DNS.txt
sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/DNS.txt
sudo chmod -R 755 /home/metallicstream/ipProccess/DNS.txt
sudo cp /var/lib/bind/xtremeville.net.hosts /home/metallicstream/ipProccess/xtremeville.net.hosts.txt
sudo cp /etc/hosts /home/metallicstream/ipProccess/hosts.txt

var=$(cat /home/metallicstream/ipProccess/oldIp.txt)
var1=$(cat /home/metallicstream/ipProccess/presentIp.txt)

var2=$(grep "$var" /home/metallicstream/ipProccess/oldIp.txt)
var3=$(grep "$var1" /home/metallicstream/ipProccess/presentIp.txt)

sudo sed -i "s/$var2/$var3/" /etc/hosts
sudo sed -i "s/$var2/$var3/" /var/lib/bind/xtremville.net.hosts
sudo cat /etc/hosts | sudo tee /home/metallicstream/ipProccess/hosts.txt
sudo cat /var/lib/bind/xtremville.net.hosts | sudo tee /home/metallicstream/ipProccess/xtremville.net.hosts.txt
sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/hosts.txt
sudo chmod 755 /home/metallicstream/ipProccess/hosts.txt
sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/xtremville.net.hosts.txt
sudo chmod 755 /home/metallicstream/ipProccess/xtremville.net.hosts.txt
sudo cp /home/metallicstream/ipProccess/hosts.txt /home/metallicstream/public_html/hosts.html
sudo cp /home/metallicstream/ipProccess/xtremeville.net.hosts.txt /home/metallicstream/public_html/xtremville.net.hosts.html
sudo chown metallicstream:www-data /home/metallicstream/public_html/hosts.html
sudo chmod 770 /home/metallicstream/public_html/hosts.html
sudo chown metallicstream:metallicstream /home/metallicstream/public_html/xtremville.net.hosts.html
sudo chmod 770 /home/metallicstream/public_html/xtremville.net.hosts.html
sudo comm /home/metallicstream/ipProccess/oldIp.txt /home/metallicstream/ipProccess/presentIp.txt | sudo tee /home/metallicstream/ipProccess/Ips.txt
sudo wc -w /home/metallicstream/ipProccess/Ips.txt| sudo tee /home/metallicstream/ipProccess/IPS.txt
sudo awk '{print $1}' /home/metallicstream/ipProccess/IPS.txt | sudo tee /home/metallicstream/ipProccess/IPS1.txt 
ANSWER=$(cat /home/metallicstream/ipProccess/IPS1.txt)
if [[ "$ANSWER" == 1 ]]
then
    echo "The IPs are still the same no cert renewal is nesscecary"
else
    sudo certbot renew --post-hook "systemctl reload apache"
    echo "SSL CERTs RE-NEWED"
fi
sudo rm /home/metallicstream/ipProccess/Ips.txt && sudo rm /home/metallicstream/ipProccess/IPS.txt && sudo rm /home/metallicstream/ipProccess/IPS1.txt
sudo curl "http://xtremeville.net/xtremeville.net.hosts" | sudo tee /var/lib/bind/xtremeville.net.hosts
sudo nmcli connection up 1a7e9545-5987-4d24-be44-de581b693547
exit