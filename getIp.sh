#!/bin/bash
set -e
	
sudo nmcli con down id "in_lan"
sudo curl https://freedns.afraid.org/dynamic/update.php?WXc3VDhaRXJGT1hyWFoweGlFdTI6MzY4NzU4MA== | sudo tee /home/metallicstream/ipProccess/test1st.txt
sudo awk '{print $3}' /home/metallicstream/ipProccess/test1st.txt | sudo tee /home/metallicstream/ipProccess/test2nd.txt
find /home/metallicstream/ipProccess/oldIp.txt || sudo cp /home/metallicstream/ipProccess/oldIp.bak.txt /home/metallicstream/ipProccess/oldIp.txt
sudo comm /home/metallicstream/ipProccess/oldIp.txt /home/metallicstream/ipProccess/presentIp.txt | sudo tee /home/metallicstream/ipProccess/Ips.txt
sudo wc -w /home/metallicstream/ipProccess/Ips.txt| sudo tee /home/metallicstream/ipProccess/IPS.txt
sudo awk '{print $1}' /home/metallicstream/ipProccess/IPS.txt | sudo tee /home/metallicstream/ipProccess/IPS1.txt 
ANSWER=$(cat /home/metallicstream/ipProccess/IPS1.txt)
if [[ "$ANSWER" == 1 ]];
then
    echo "The IPs are still the same no actions need to be done at this time"
	sudo nmcli con up 1a7e9545-5987-4d24-be44-de581b693547
    exit
else
    sudo awk '{print $1}' /home/metallicstream/ipProccess/oldIp.txt | sudo tee /home/metallicstream/ipProccess/IPTEST.txt
	OLIP=$(wc -l /home/metallicstream/ipProccess/IPTEST.txt)

	if [[ "$OLIP" = 1 ]];
	then
		sudo rm /home/metallicstream/ipProccess/IPTEST.txt
		sudo rm /home/metallicstream/ipProccess/oldIp.txt
		sudo cp -u /home/metallicstream/ipProccess/presentIp.txt /home/metallicstream/ipProccess/oldIp.txt
		sudo cp /home/metallicstream/ipProccess/oldIp.txt /home/metallicstream/ipProccess/oldIp.bak.txt
		sudo rm /home/metallicstream/ipProccess/oldIp.txt
		sudo cp /home/metallicstream/ipProccess/presentIp.txt /home/metallicstream/ipProccess/oldIp.txt
		sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/oldIp.txt
		sudo rm /home/metallicstream/ipProccess/presentIp.txt
		sudo curl -s http://sync.afraid.org/u/qrcJxZ7KhNmtba8Px9tapg7u/ | sudo tee /home/metallicstream/ipProccess/test.txt
		sudo awk '{print $3}' /home/metallicstream/ipProccess/test.txt | sudo tee /home/metallicstream/ipProccess/test1.txt
		sudo cat /home/metallicstream/ipProccess/test1.txt | sudo tee /home/metallicstream/ipProccess/newIp.txt
		sudo cp /home/metallicstream/ipProccess/newIp.txt /home/metallicstream/ipProccess/presentIp.txt
		sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/presentIp.txt
		sudo rm /home/metallicstream/ipProccess/newIp.txt
		sudo rm /home/metallicstream/ipProccess/test.txt
		sudo rm /home/metallicstream/ipProccess/test1.txt
		sudo /home/metallicstream/bin/./addDns.sh
	else
		sudo rm /home/metallicstream/ipProccess/IPTEST.txt
		sudo cp -u /home/metallicstream/ipProccess/presentIp.txt /home/metallicstream/ipProccess/oldIp.txt
		sudo cp /home/metallicstream/ipProccess/oldIp.txt /home/metallicstream/ipProccess/oldIp.bak.txt
		sudo rm /home/metallicstream/ipProccess/oldIp.txt
		sudo cp /home/metallicstream/ipProccess/presentIp.txt /home/metallicstream/ipProccess/oldIp.txt
		sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/oldIp.txt
		sudo rm /home/metallicstream/ipProccess/presentIp.txt
		sudo curl -s https://freedns.afraid.org/dynamic/update.php?WXc3VDhaRXJGT1hyWFoweGlFdTI6MjEyOTQzNzM= | sudo tee /home/metallicstream/ipProccess/test.txt
		sudo awk '{print $3}' /home/metallicstream/ipProccess/test.txt | sudo tee /home/metallicstream/ipProccess/test1.txt
		sudo cat /home/metallicstream/ipProccess/test1.txt | sudo tee /home/metallicstream/ipProccess/newIp.txt
		sudo cp /home/metallicstream/ipProccess/newIp.txt /home/metallicstream/ipProccess/presentIp.txt
		sudo chown metallicstream:metallicstream /home/metallicstream/ipProccess/presentIp.txt
		sudo rm /home/metallicstream/ipProccess/newIp.txt
		sudo rm /home/metallicstream/ipProccess/test.txt
		sudo rm /home/metallicstream/ipProccess/test1.txt
		sudo /home/metallicstream/bin/./addDns.sh
	fi
fi