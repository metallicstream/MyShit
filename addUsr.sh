#!/bin/bash

# /home/metallicstream/bin/./addUsr.sh UsrName password

#Variables 
userName=$1 
pw=$2 

#Program 
sudo useradd -p $pw $userName 

sudo echo "user added"

#make drive 
sudo mkdir /home/$userName 
sudo chown $userName:www-data /home/$userName 
sudo chmod 777 /home/$userName 
sudo dd if=/dev/zero of=/home/$userName/$userName.img bs=2G count=1 

sudo echo "so far so good, drive filled w/0s" 

sudo stat /home/$userName/$userName.img 

echo "statx is done" 

sudo mkfs -t ext4 /home/$userName/$userName.img > /home/tempFiles/uuid.txt

sudo echo "filesystem made"

sudo grep -w "UUID: *-*-*-*-*" /home/tempFiles/uuid.txt > /home/tempFiles/UUID.txt 
sudo awk '{print $2,$3}' /home/tempFiles/UUID.txt > /home/tempFiles/uuid.txt 
sudo sed -e 's/$/ /home/$userName	default	0	0/' -i /home/tempFiles/uuid.txt

sudo echo "UUID.txt Made" 

sudo chown $userName:www-data /home/$userName/$userName.img 
sudo chmod 777 /home/$userName/$userName.img 
sudo mount -t ext4 /home/$userName/$userName.img /home/$userName 
sudo mkdir /home/$userName/public_html 

sudo echo "public_html made" 

sudo chown $userName:www-data /home/$userName/public_html 
sudo chmod 755 /home/$userName/public_html 
sudo chmod 777 /etc/fstab 

sudo echo "perms changed" 

sudo cat /home/tempFiles/uuid.txt >> /etc/fstab 
source /etc/fstab 
sudo chmod 755 /etc/fstab 

sudo echo "fstab modified"

sudo echo "<!DOCTYPE html>
<html>
<head>
<title>'.$userName.'</title>
<style></style>
</head>
<body>
<div>
<header><h1></h1></header>
<article></article>
<article></article>
</div>
<footer><address></address></footer>
</body>
</html>" > /home/$userName/public_html/index.html

sudo echo "index.html built & loaded"

#set-up mailbox 
mkdir /var/mail/$userName

sudo echo "User mailbox set-up"
 
#set-up web server
cat /home/servers/webServer.txt && tee /etc/apache2/sites-available/$userName.xtremville.net.conf
ln /etc/apache2/sites-available/$userName.xtremville.net.conf /etc/apache2/sites-enabled/$userName.xtremville.net.conf

sudo echo "webserver linked and loaded"

#set-up FTP server
cat /home/webShitForFreeSites/yourShit/servers/ftp.txt && echo `tee` >> /etc/proftpd/modules.conf

sudo echo "FTP server set-up"

#fill pulic_html
fillWebSpace(fileName) {
cat /home/webShitForFreeSites/yourShit && tee /home/$userName/public_html/$fileName
}

cp -r /home//someShit/freeWebExample/js
chown $userName:www-data /home/$userName/public_html/js
chmod 755 /home/$userName/public_html/js
cp -r /home//someShit/freeWebExample/css
chown $userName:www-data /home/$userName/public_html/css
chmod 755 /home/$userName/public_html/css
cp -r /home//someShit/freeWebExample/images
chown $userName:www-data /home/$userName/public_html/images
chmod 755 /home/$userName/public_html/images
fillWebSpace(index.html)
chown $userName:www-data /home/$userName/public_html/index.html
chmod 755 /home/$userName/public_html/index.html
fillWebSpace(page2.html)
chown $userName:www-data /home/$userName/public_html/page2.html
chmod 755 /home/$userName/public_html/page2.html
fillWebSpace(page3.html)
chown $userName:www-data /home/$userName/public_html/page3.html
chmod 755 /home/$userName/public_html/page3.html
fillWebSpace(page4.html)
chown $userName:www-data /home/$userName/public_html/page4.html
chmod 755 /home/$userName/public_html/page4.html
fillWebSpace(page5.html)
chown $userName:www-data /home/$userName/public_html/page5.html
chmod 755 /home/$userName/public_html/page5.html

#append new subDomain to DNS
echo "`$userName`.xtremville.net.	IN	CNAME	`$userName`." >> /var/lib/bind/xtremville.net.hosts

#append hosts file
echo "24.20.208.222	`$userName`.xtremville.net	`$userName`" >> /etc/hosts

#restart servers
/etc/init.d/apache2 restart
/etc/init.d/named restart
/etc/init.d/proftpd restart

#certbot for ssl cert
certbot --apache --domain $userName.xtremville.net

#send message to usr
echo "Your website is built,ready...Go! Uno your pw, do not loose it! We have no way of retrieving it! Your web URL is `$userName`.xtremville.net"
