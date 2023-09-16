#!/bin/bash

# /home/metallicstream/bin/./quickAddUsr.sh UsrName password

#Variables 
userName=$1 
pw=$2
IP=$3
sh=$(sudo echo -n $pw | sudo md5sum)

#Program 
sudo useradd -p $sh $userName 

sudo echo "user password added with md5 encryption"

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

# build web page
buildWebPage () {
# Variable
page=$1
link=$2
link1=$3
link2=$4
link3=$5
link4=$6

sudo echo '<!DOCTYPE html>
<html>
<head>
<title>'.$usrName.'</title>
<style></style>
</head>
<body>
<div>
<header><h1>Welcome to '.$userName.'s Home Page</h1></header>
<ul><li><aside><ul><li><a href="'.$page.'">'.$link.'</a></li>
<li><a href="'.$page.'">'.$link1.'</a></li>
<li><a href="'.$page.'">'.$link2.'</a></li>
<li><a href="'.$page.'">'.$link3.'</a></li>
<li><a href="'.$page.'">'.$link4.'</a></li>
</ul></aside></li>
<li><article></article>
<article></article></li>
</ul>
</div>
<iframe src="https//xtremville.net/footer.html" style="border: none; width: 20%; height: auto;" title="Our Sponsor! Want a website<a href="https://xtremesporto.com">Click Here</a>"></iframe>
</body>
</html>' > /home/$userName/public_html/$page.html
}

buildWebPage index HOME Page2 Page3 Page4 Page5
buildWebPage page2 Page2 HOME Page3 Page4 Page5
buildWebPage page3 Page3 HOME Page2 Page4 Page5
buildWebPage page4 Page4 HOME Page5 Page2 Page3
buildWebPage page5 Page5 HOME Page2 Page4 Page5

sudo echo "Website pages built and loaded total of 5"

sudo echo '<VirtualHost *:443>
    DocumentRoot "/home/metallicstream/public_html"
    ServerName $userName.xtremville.net
    <Directory "/home/$userName/public_html">
        Options None
        Require all granted
    </Directory>
</VirtualHost>' > /etc/apache2/sites-available/$userName.xtremville.net.conf

sudo ln /etc/apache2/sites-available/$userName.xtremville.net.conf /etc/apache2/sites-enabled/$userName.xtremville.net.conf

sudo echo "Webserver built"

sudo /etc/init.d/apache2 restart

sudo echo "Webserver restarted"

#set-up mailbox 
mkdir /var/mail/$userName

sudo echo "usr mailbox created"

#append new subDomain to DNS
sudo echo "`$userName`.xtremville.net.	IN	CNAME	`$userName`." >> /var/lib/bind/xtremville.net.hosts
sudo /etc/init.d/bind restart

sudo echo "DNS server updated and restarted"

# append hosts file
sudo echo "`$IP`	`$userName`.xtremville.net	`$userName`" >> /etc/hosts

sudo echo "Hosts file appended with usr.host.net and IP address"

sudo certbot run -d $userName.xtremville.net
sudo /etc/init.d/apache2 restart

sudo echo "Encryption of your website is complete"