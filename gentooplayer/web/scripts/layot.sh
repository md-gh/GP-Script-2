#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -c)
            layot="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done
. /opt/.gentooplayer/function/fcolors.sh

layott=$(grep -F "$layot" /opt/.gentooplayer/web/scripts/script/layot/layot | awk '{print $1}')

sed -i '/keymap=/c\keymap=''"'"$layott"'"''' /etc/conf.d/keymaps
echo
echo
echo -e "$BGreen Keyboard layout switching to $layot $color_off"
echo
echo -e "$BRed reboot the system to make the changes effective$color_off"
