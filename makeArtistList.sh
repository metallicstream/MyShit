#!/bin/bash

# put this file in your ~/bin directory
# if there is not a bin directory the command is 
# "sudo mkdir ~/bin && sudo chown usrName:groupName ~/bin && sudo chmod 755 ~/bin" 
# you can put any .sh files in the bin! 
# .sh Files Must be made executable as 755 or rw+ r+ r x
# To run > /home/usrName/bin/./makeArtistList.sh

#variables
path=$1

#Commands
cd $path
sudo ls > artistList.txt
sudo chmod 777 $path/artistList.txt
