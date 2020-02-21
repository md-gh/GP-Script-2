#!/bin/bash

function pausa() {
    echo
    read -s -p 'Press "Enter" to continue... or CTRL+C to exit'
    clear
    echo
}

function pausa1() {
    echo
    read -s -p 'Done, press "Enter" to return to the menu...'
    clear
    select_twk
    echo
}


function select_twk() {
    twk=""
    clear
    echo -e "\e[38;5;88mA restart is required to apply the changes\e[0m\n"
    while [ "$twk" == "" ] ; do
        cat <<-ECHOICE

	Choose :

  0) turn off the HDMI

  1) deactivate the ACT LED

  2) disable the PWR LED

  3) overcloc SD Card

  4) change the kernel settings on the network buffer

  5) disable linux console

  6) disable SSH server

  7) remove the search for the swap partition at boot and its "service"

  8) RESTART/RIAVVIA

  9) exit


ECHOICE


        read -N1 -p 'type the number corresponding to the type of change (0|1|2|3|4|5|6|7|8|9): ' Sceltatwk
        echo
        case "$Sceltatwk" in
            0)
                twk="hdmi"
                ;;
            1)
                twk="act"
                ;;
            2)
                twk="pwr"
                ;;
            3)
                twk="sd"
                ;;
            4)
                twk="buffer"
                ;;
            5)
                twk="console"
                ;;
            6)
                twk="ssh"
                ;;
            7)
                twk="swap"
                ;;
            8)
                twk="reboot"
                ;;
            9)
                twk="esch"
                ;;
            *)
                clear
                echo -e "\a\nError: Unspecified selection.\nPlease enter a number between 0 and 1.\n"
        esac
        #    if [ "$twk" != "" ]; then
        #      echo -e "\nscelta: \e[38;5;88m$twk\e[0m\n"
        #      read -s -N1 -p 'Confermi la scelta? (y/N)'
        #      clear
        #      echo
        #      [ "$REPLY" != "s" ] && twk=""
        #    fi
    done
}

function hdmi() {
    echo "hdmi_blanking=2" >> /boot/config.txt
    echo "hdmi_ignore_hotplug=1" >> /boot/config.txt
    echo "hdmi_ignore_composite=1" >> /boot/config.txt
}

function act() {
    echo "dtparam=act_led_trigger=none" >> /boot/config.txt
    echo "dtparam=act_led_activelow=on" >> /boot/config.txt
}

function pwr() {
    echo "dtparam=pwr_led_trigger=none" >> /boot/config.txt
    echo "dtparam=pwr_led_activelow=on " >> /boot/config.txt
}

function sd() {
    echo "dtoverlay=sdhost,overclock_50=100" >> /boot/config.txt
}

function console() {
    cat > /etc/inittab <<EOF
#
# /etc/inittab:  This file describes how the INIT process should set up
#                the system in a certain run-level.
#
# Author:  Miquel van Smoorenburg, <miquels@cistron.nl>
# Modified by:  Patrick J. Volkerding, <volkerdi@ftp.cdrom.com>
# Modified by:  Daniel Robbins, <drobbins@gentoo.org>
# Modified by:  Martin Schlemmer, <azarah@gentoo.org>
# Modified by:  Mike Frysinger, <vapier@gentoo.org>
# Modified by:  Robin H. Johnson, <robbat2@gentoo.org>
# Modified by:  William Hubbs, <williamh@gentoo.org>
#

# Default runlevel.
id:3:initdefault:

# System initialization, mount local filesystems, etc.
si::sysinit:/sbin/openrc sysinit

# Further system initialization, brings up the boot runlevel.
rc::bootwait:/sbin/openrc boot

l0:0:wait:/sbin/openrc shutdown
l0s:0:wait:/sbin/halt -dhnp
l1:1:wait:/sbin/openrc single
l2:2:wait:/sbin/openrc nonetwork
l3:3:wait:/sbin/openrc default
l4:4:wait:/sbin/openrc default
l5:5:wait:/sbin/openrc default
l6:6:wait:/sbin/openrc reboot
l6r:6:wait:/sbin/reboot -dkn
#z6:6:respawn:/sbin/sulogin

# new-style single-user
su0:S:wait:/sbin/openrc single
su1:S:wait:/sbin/sulogin

# TERMINALS
#x1:12345:respawn:/sbin/agetty 38400 console linux
#c1:12345:respawn:/sbin/agetty 38400 tty1 linux
#c2:2345:respawn:/sbin/agetty 38400 tty2 linux
#c3:2345:respawn:/sbin/agetty 38400 tty3 linux
#c4:2345:respawn:/sbin/agetty 38400 tty4 linux
#c5:2345:respawn:/sbin/agetty 38400 tty5 linux
#c6:2345:respawn:/sbin/agetty 38400 tty6 linux

# SERIAL CONSOLES
#s0:12345:respawn:/sbin/agetty -L 9600 ttyS0 vt100
#s1:12345:respawn:/sbin/agetty -L 9600 ttyS1 vt100

# What to do at the "Three Finger Salute".
ca:12345:ctrlaltdel:/sbin/shutdown -r now

# Used by /etc/init.d/xdm to control DM startup.
# Read the comments in /etc/init.d/xdm for more
# info. Do NOT remove, as this will start nothing
# extra at boot if /etc/init.d/xdm is not added
# to the "default" runlevel.
x:a:once:/etc/X11/startDM.sh

# Architecture specific features
#f0:12345:respawn:/sbin/agetty 9600 ttyAMA0 vt100
EOF
}

function ssh() {
    rc-update delete sshd default
}

function swap() {
    rc-update delete swap boot
}

function esch() {
    exit 0
}

function rboot() {
    reboot
}

function buffer {
    /opt/.gentooplayer/script/buffer.sh
}

mount /dev/mmcblk0p1 2>/dev/null

echo -e "Some info on the options that will follow are in the file /opt/.gentooplayer/script/twk_info"
echo -e "do they want to view now? y/n"
read vogliono
if [ "$vogliono" = "y" ]; then
    less /opt/.gentooplayer/script/twk_info
fi

select_twk

$twk
