#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            dirb="$2"
            shift # past argument
            ;;
        -b)
            dirn="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

if [ ${#dirb} -ne 0 ] && [ ${#dirn} -ne 0 ]; then
    echo "You cannot use both options at the same time"
    exit 0
fi


if [ ${#dirb} -eq 0 ]; then
    echo ""
else
    if [[ $(findmnt -M "/media/$dirb") ]]; then
        echo "The directory $disk has been mounted"
        rsync -a /etc/default /media/$dirb/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
        rsync -a /etc/local.d /media/$dirb/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
        rsync -a /etc/conf.d /media/$dirb/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
        rsync -a /etc/fstab /media/$dirb/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
        rsync -a /etc/mpd.conf /media/$dirb/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
        ls -1v /etc/runlevels/default/ > /media/$dirb/gp-backup-"$(date '+%Y-%m-%d-%H%M')"/rcdefault
        echo -e "$Green"Backup completed"$Color_Off"
        echo
        echo -e "$Yellow Wait... $Color_Off" && sleep 5
    else
        echo "The directory $dirb is not mounted exit"
        exit 0
    fi
fi




if [ ${#dirn} -eq 0 ]; then
    echo ""
else
    dirf=$(find /media -name $dirn | sed 's/'$dirn'//g')
    if [[ $(findmnt -M "$dirf") ]]; then
        cp -rp $dirf/"$dirn"/* /etc/
        rm /etc/rcdefault
        for process in `cat $dirf/"$dirn"/rcdefault` ; do
            f="$process"
            rc-update add "$f" default
        done
        echo -e "$Green"Restore completed"$Color_Off"
        echo
        echo -e "$Yellow Wait... $Color_Off" && sleep 5
    else
        echo "The directory $dirf is not mounted exit"
        exit 0
    fi
fi

if [ ${#dirb} -eq 0 ] && [ ${#dirn} -eq 0 ]; then
    echo "you didn't make any choice"
fi

#if [ ${#dirn} -eq 0 -a ${#dirb} -eq 0} ]; then
#   echo "you didn't make any choice"
#fi
