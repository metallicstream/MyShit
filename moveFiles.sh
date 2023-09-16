#!/bin/bash

# ~/bin/./moveFiles.sh *search*criteria*.* /path/to/directory/

#variables
path=$2
searchCriteria=$1

#Commands
cd /home/metallicstream/Music && sudo ls -c -Q $searchCriteria > /home/metallicstream/Music/newFile.txt && sudo mkdir -p $path && sudo chown metallicstream:metallicstream $path && sudo chmod 777 $path && sudo mv -t $(cat `echo "/home/metallicstream/Music/newFile.txt"`) $path
sudo echo "$(ls $path)"
