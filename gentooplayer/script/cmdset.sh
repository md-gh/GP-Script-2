#!/bin/bash

echo -e "edit the cmdline.txt? y/n"
read editare
if [ "$editare" = "y" ]; then
    mount /dev/mmcblk0p1 2>/dev/null
    nano /boot/cmdline.txt
fi
echo -e "restart the rpi? y/n"
read riavviare
if [ "$riavviare" = "y" ]; then
    reboot
fi

exit 0
