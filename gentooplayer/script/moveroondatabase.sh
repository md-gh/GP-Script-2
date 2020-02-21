#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh


echo -e "Do you want move roon database? y/n"
read move
if [ "$move" = "n" ]; then
    exit 0
else
    clear
    echo ""
    echo -e "$Yellow"
    echo "partitions mounted in your system:"
    echo ""
    echo -e "$Color_Off"
    findmnt -lo source,target,fstype,label,options,used,avail,use% -t ext4,fuseblk
    echo ""
    echo -e "$Yellow"
    echo -e "if you do not have mounted partitions use the "$BBlue"mountfs$Color_Off "$Yellow"command to mount the partition disk on your system."
    echo ""
    echo -e "$Color_Off"
    echo -e "Do you want to continue? y/n"
    read continue
    if [ "$continue" = "n" ]; then
        exit 0
    else
        echo "Select the partition (ex. sda3, sdb2 etc.):"
        read disk
        mountin=$(grep $disk /etc/mtab | cut "-d " -f2)
        echo ""
        echo -e "You chose the partition "$BBlue"/dev/$disk"$Color_Off" mounted on "$BBlue"$mountin"$Color_Off""
        echo -e "Do you want to continue? y/n"
        read continue
        if [ "$continue" = "y" ]; then
            mkdir $mountin/roondatabase
            echo "Copying Database on $disk"
            cp -R /root/.RoonServer/Database $mountin/roondatabase/
            rm -rf /root/.RoonServer/Database
            ln -s $mountin/roondatabase/Database /root/.RoonServer
            echo -e "$Yellow"
            echo "database is now in:"
            file /root/.RoonServer/Database
            echo -e "$Color_Off"
            sleep 5
        else
            exit 0
        fi
    fi
fi
