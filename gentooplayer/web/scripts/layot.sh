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

#oper=$(awk '{print $1}' <<< "$alsav")

#alsasw=$(ls -1v /usr/portage/packages/media-libs/ | sed 's/.tbz2//' | sed 's/alsa-lib-//' | cat -n | awk '{if(NR=='$oper') print $0}' | awk '{print $2}')
#echo "$kernn"

layott=$(grep -F "$layot" /opt/.gentooplayer/web/scripts/script/layot/layot | awk '{print $1}')

sed -i '/keymap=/c\keymap='"'$layott'"'' /etc/conf.d/keymaps

echo "Keyboard layout switching to $layot"

echo "reboot the system to make the changes effective"
