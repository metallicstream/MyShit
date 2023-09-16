#!/bin/bash

# This is a BASH script for Linux to copy Music to another directory or drive
# Add this file in bin directory, if you do not have a bin folder
# open a terminal and type this command
# "sudo mkdir ~/bin && sudo chown usrName:groupName ~/bin && sudo chmod 755 ~/bin" 
# /home/usrName/bin/./movemusic.sh artistDirectory /path/to/destination/folder /origPath/to/artistDirectory

#Variables
artist=$1
path=$2
origPath=$3

#Commands
sudo chown -R metallicstream:metallicstream $origPath/$artist
sudo chmod -R 755 $origPath/$artist
sudo cp -r $origPath/$artist $path/$artist
sudo rm -R $path/*.wma
sudo rm -R $path/*copy*.*
