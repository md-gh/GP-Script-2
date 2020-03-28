#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh


umount -l /etc 2>/dev/null
umount /mnt/ramdisk1 2>/dev/null
rc-update del ramdisk


echo -e "$Red you have to restart the system, restart now? $Color_Off $Green y/n$Color_Off"
read reboot
if [ "$reboot" = "y" ]; then
    reboot
fi
