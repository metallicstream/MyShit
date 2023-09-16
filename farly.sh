#!/bin/bash

PATH=$1
USR="metallicstream"
GRP=$USR
PERMS="755"

sudo touch $PATH
sudo chown $USR:$GRP $PATH
sudo chmod $PERMS $PATH
