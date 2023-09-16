#!/bin/bash

#Variables
userName = $(cat /home/webShitForFreeSites/yourShit/servers/userName.txt);
var=$(cat $userName /etc/passwd)
#check if username exists
grep $userName /etc/passwd

#conditionally check usr to report back
if[$var = $userName]
then
	echo "Your userName choice is not unique"
	sleep(5)
	/usr/bin/php /var/www/html/freeSites/join1.php
else
	echo "Your userName is unique"
fi
