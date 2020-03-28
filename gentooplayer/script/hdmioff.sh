#!/bin/bash

mount /dev/mmcblk0p1

echo -e "disable HDMI? y/n"
read disattivare
if [ "$disattivare" = "y" ]; then
    echo "hdmi_blanking=2" >> /boot/config.txt
    echo "hdmi_ignore_hotplug=1" >> /boot/config.txt
    echo "hdmi_ignore_composite=1" >> /boot/config.txt
fi
echo -e "disable ACT-LED? y/n"
read disattivare
if [ "$disattivare" = "y" ]; then
    echo "dtparam=act_led_trigger=none" >> /boot/config.txt
    echo "dtparam=act_led_activelow=on" >> /boot/config.txt
fi
echo -e "disable PWR-LED? y/n"
read disattivare
if [ "$disattivare" = "y" ]; then
    echo "dtparam=pwr_led_trigger=none" >> /boot/config.txt
    echo "dtparam=pwr_led_activelow=on " >> /boot/config.txt
fi
echo -e "overcloc SD-Card? y/n"
read overcloccare
if [ "$overcloccare" = "y" ]; then
    echo "dtoverlay=sdhost,overclock_50=100" >> /boot/config.txt
fi
echo -e "change kernel settings on the network buffer? y/n"
read cambiare
if [ "$cambiare" = "y" ]; then
    /opt/.gentooplayer/script/buffer.sh
fi
echo -e "restart the rpi? y/n"
read riavviare
if [ "$riavviare" = "y" ]; then
    reboot
fi

exit 0
