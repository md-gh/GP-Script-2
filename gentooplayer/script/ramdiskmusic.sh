#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh
clear
echo
echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
echo
free -m
echo
echo -e "\e[38;5;82m--------------------------------------------------\e[0m"

echo -e "$Yellow Check the free memory, see above.$Color_Off"
echo
echo -e "$Red"
read -p  "type the amount of memory to be dedicated to ramdisk, in megabytes:" ram
echo -e "$Color_Off"

mkdir /mnt/ramdiskmusic 2>/dev/null
mkdir /media/ramdiskmusic 2>/dev/null
umount -l /media/ramdiskmusic/ /mnt/ramdiskmusic/ 2>/dev/null

mount none -t tmpfs /mnt/ramdiskmusic -o size="$ram"M
rsync -a /media/ramdiskmusic/ /mnt/ramdiskmusic
mount -o bind /mnt/ramdiskmusic/ /media/ramdiskmusic/

echo -e "$BGreen copy the music you want to listen to ram on$Color_Off $BRed /media/ramdiskmusic$Color_Off"
