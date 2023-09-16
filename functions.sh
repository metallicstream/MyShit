#!/bin/bash
# Functions by Metallic Stream 3.29.23 put this file in ~/bin and add this file as a source page in your bash scipts
# example source /home/joe/example/lib_example.sh

mkFile(){
echo -e "Enter the your path"
read PATH
echo -e "Enter your userName"
read USR
echo -e "Enter the name of the group"
read GRP
echo -e "Enter the permissions you want: like 777"
read PERMS
sudo touch $PATH
sudo chown $USR:$GRP $PATH
sudo chmod $PERMS $PATH
}
mkFile

mkdirec(){
echo -e "Enter the your path"
read PATH
echo -e "Enter your userName"
read USR
echo -e "Enter the name of the group"
read GRP
echo -e "Enter the permissions you want: like 777"
read PERMS
mkdir $PATH
chown $USR:$GRP $PATH
chmod $PERMS $PATH
}

remFile(){


}

remDir(){


}

copyFile(){


}

copyDir(){


}

instWebmin(){
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sh setup-repos.sh -y
apt install webmin -fy
}

searchCache(){
echo -e "Enter the name of your query"
read QUERY
apt search $QUERY | less
}

addAlias(){
echo -e "Enter the alias name"
read ANAME
echo -e "Enter the command you want to alias"
read COMM
sudo echo "alias $ANAME'=$COMM'" >> ~/.bashrc
}

inst1prog(){
echo -e "Enter the program you want to install"
read PROG
apt install $PROG -f
}

mntDrv(){
#mount drive of choice
echo -e "Enter the Drive example sda1"
read DRV
echo -e "Enter the mount point\nexample /home/userName/DeviceName"
read MNTPT
#mount point i.e. /home/user/mountPoint
DRV=$1		#example = sda1 = /dev/sda1
MNTPT=$2	#example = /mnt or /newFolder
mount /dev/$DRV $MNTPT
}

mntUSB(){
#mount usb drive in folder @ /home/userName/USB
whoami=$whoami
CKFOLD=$(cd /home/$whoami/USB)
$CKFOLD
if [ $? -eq 0 ]; then
    echo "Folder @ /home/$whoami/USB OK"
else
    echo "No USB directory @ /home/$whoami/USB"
    echo "Making USB folder now"
    mkdirec /home/$whoami/USB $whoami $whoami 755
    echo "Directory Made"
fi
echo -e "Enter the Drive Label\nI.E. D or USB MYDRIVE\nWhatever your drive LABEL is"
read LABEL
echo Your LABEL is $LABEL
DEVICE=$(blkid -o list -L $LABEL)
mount $DEVICE /home/$whoami/USB
echo "Drive $DEVICE is mounted @ /home/$whoami/USB"
echo "Proccess Complete"
}
