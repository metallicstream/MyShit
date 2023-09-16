#!/bin/bash

path=$1
usr=$2
perms=$3

touch $path
chown $usr $path
chmod $perms $path
