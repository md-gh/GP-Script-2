#!/bin/bash
bldblu='\e[1;34m' # Blu
bldylw='\e[1;33m' # Giallo
txtrst='\e[0m'    # Text Resett


function audio {
    echo "AUDIO CARDS"
    cards_path=$(echo $(find /proc/asound -type d -name "card*") | awk  '{print $NF}' | tail -c 2)
    fw_devices=$(find /sys/devices/ -maxdepth 4 -type d -name "fw*" | wc -l)
    echo -e -n "CARD\tTYPE\t\t\tADDRESS\t\t\tNAME
--------------------------------------------------------------------------------------------------------
    "
    for (( i=0; i<=$cards_path; i++ )); do
        if [[ -d  "/proc/asound/card"$i"" ]]; then
            echo -n "card$i"
            usbid=$(find "/proc/asound/card"$i -type f -name "usbid" -exec cat {} \; )
            if [[ -z $usbid ]]; then
                if [[ -d "/proc/asound/card"$i"/firewire" ]]; then
                    echo -e -n "\tFirewire Audio card"
                    for (( j=0; j<$fw_devices; j++ )); do
                        if [[ $(cat /proc/asound/cards | egrep "fw$j") ]]; then
                            echo -e -n "\tfw$j"
                            echo -n "   --> -- "
                            echo -e -n "\t\t$(find "/proc/asound/card"$i -type f -name "info" -exec cat {} \; | egrep "name" | head -1 | sed 's/name\:\ //g' | awk '{print $1,$2,$3}')"
                        fi
                    done
                else
                    echo -e -n "\tInternal Audio card"
                    echo -e -n "\tcard"$i
                    echo -n " --> -- "
                    echo -e -n "\t\t$(find "/proc/asound/card"$i -type f -name "info" -exec cat {} \; | egrep "name" | head -1 | sed 's/name\:\ //g' | awk '{print $1,$2,$3}' )"
                fi
            else
                echo -e -n "\tUSB Audio card"
                echo -e -n "${bldblu}\t\tusb"$(cat "/proc/asound/card"$i"/usbbus" | rev | cut -b5)${txtrst}
                echo -n "  --> "$usbid
                echo -e -n "\t$(find "/proc/asound/card"$i -type f -name "usbmixer" -exec cat {} \; | egrep "Card" | head -1 | sed 's/Card\://g' | awk '{print $1,$2,$3}' )"
            fi
            echo ""
            if [[ -a  "/proc/asound/card"$i"/pcm0p/sub0/hw_params" ]]; then
                echo -e "card$i\tSTATUS  --> "$(cat /proc/asound/card"$i"/pcm0p/sub0/hw_params)
            else
                echo -e "card$i\tSTATUS  --> unavailable"
            fi
            echo "--------------------------------------------------------------------------------------------------------"
        fi
    done
}
function run_as_root() {
    [ "$(whoami)" == "root" ] || {
        echo -e '\a\nWARNING: This command must be run from the "SuperUser" (root user).'
        exec su -c "$0"
    }
}
run_as_root
clear
echo -e "${bldylw}Before running this script, it would be useful to check that the audio card IRQ is only used by the same${txtrst}"
echo -e "${bldblu}rtstatus"
echo -e "rtmonitorirq${txtrst}"
echo -e "you want to continue with the rtirq configuration? y/n"
read continue
if [ "$continue" = "n" ]; then
    exit 0
fi
clear

echo "--------------------------------------------------------------------------------------------------------"
route -n
echo "--------------------------------------------------------------------------------------------------------"
audio
echo "--------------------------------------------------------------------------------------------------------"
echo -e "${bldblu}--------------------------------------------------------------------------------------------------------${txtrst}"
echo -e "${bldylw}YOU HAVE ALL INFORMATION ABOVE:"
echo "name_rete IN THE COLUMN Iface"
echo -e "AND THE USB TO WHICH THE AUDIO CARD INCLUDES IN BLUE${txtrst}"
echo -e "${bldblu}--------------------------------------------------------------------------------------------------------${txtrst}"
echo "--------------------------------------------------------------------------------------------------------"
getinfo()
{
    read -p "Enter name_usb (looks like usb1,usb2 or usb3 etc, for dac i2s the option to put should be dwc_otg, check with top):"	nameusb
    read -p "Enter name rete (looks like enp3s0, enp2s0 or eth0 etc):"	namerete
    read -p "Highest priority (looks like 80,85,90,max is 95):"                 priority
    read -p "Priority decrease step: (looks like 2,3,5):"              step
}

writeirqconf()
{
    cat > /etc/conf.d/rtirq <<EOF
#
# Copyright (C) 2004-2015, rncbc aka Rui Nuno Capela.
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2
#   of the License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program; if not, write to the Free Software Foundation, Inc.,
#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# /etc/conf.d/rtirq
# /etc/default/rtirq
#
# Configuration for IRQ thread tunning,
# for realtime-preempt enabled kernels.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 or later.
#

# IRQ thread service names
# (space separated list, from higher to lower priority).
# RTIRQ_NAME_LIST="rtc snd usb i8042" # old
# RTIRQ_NAME_LIST="rtc snd xhci enp i915 usb hcd smb"
RTIRQ_NAME_LIST="rtc $nameusb $namerete"

# Highest priority.
RTIRQ_PRIO_HIGH=$priority

# Priority decrease step.
RTIRQ_PRIO_DECR=$step

# Lowest priority.
RTIRQ_PRIO_LOW=51

# Whether to reset all IRQ threads to SCHED_OTHER.
RTIRQ_RESET_ALL=0

# On kernel configurations that support it,
# which services should be NOT threaded
# (space separated list).
#RTIRQ_NON_THREADED="rtc snd"
RTIRQ_NON_THREADED=""

# Process names which will be forced to the
# highest realtime priority range (99-91)
# (space separated list, from highest to lower priority).
RTIRQ_HIGH_LIST="timer snd-hrtimer"
EOF
    /etc/init.d/rtirq restart
    exit 0
}



getinfo
echo ""
echo "So your settings are:"
echo "Your name_usb is:           $nameusb"
echo "Your name rete is:          $namerete"
echo "Highest priority is:        $priority"
echo "Priority decrease step is:  $step"

echo ""

while true; do
    read -p "Are these informations correct? [y/n]: " yn
    case $yn in
        [Yy]* ) writeirqconf ;;
        [Nn]* ) getinfo ;;
        * ) echo "Pleas enter y or n!" ;;
    esac
done
