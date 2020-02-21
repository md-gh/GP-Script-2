#!/bin/bash

################# Select Kernel ################################################
backups(){
    clear
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "        $color1"GentooPlayer"$color_off - $BBlue"Backup/Restore All Settings"$Color_Off"
    echo -e ""
    echo -e "It is assumed that the backup disk has already been mounted."
    echo -e "Otherwise go back and use $BBlue"mountfs"$Color_Off or the $BBlue"webinterface - local mount"$Color_Off to mount the disk and then try again."
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [1] Backup all settings"
    echo -e " [2] Restore all setting"
    echo ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [3] $BBlue"Main Menu"$Color_Off"
    echo -e " [0] $BBlue"Exit"$Color_Off"
    echo ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "$Green"Choose your operation:"$Color_Off"
    echo ""
    read -p  " [0 - 3]:" oper
    echo -e ""
    case $oper in

        1)
            echo
            echo
            echo -e "$Green"disk list:"$Color_Off"
            echo
            echo
            ls -1v /media | cat -n
            echo
            echo -e "$Green"
            echo
            read -p  "Choose your disk for backup (corresponding number): " oper
            echo -e "$Color_Off"
            disk=$(ls -1v /media | cat -n | awk '{if(NR=='$oper') print $0}'| awk '{print $2}')
            if [[ $(findmnt -M "/media/$disk") ]]; then
                echo "The directory $disk has been mounted"
            else
                echo "The directory $disk is not mounted exit"
                exit 0
            fi
            rsync -a /etc/default /media/$disk/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
            rsync -a /etc/local.d /media/$disk/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
            rsync -a /etc/conf.d /media/$disk/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
            rsync -a /etc/fstab /media/$disk/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
            rsync -a /etc/mpd.conf /media/$disk/gp-backup-"$(date '+%Y-%m-%d-%H%M')"
            ls -1v /etc/runlevels/default/ > /media/$disk/gp-backup-"$(date '+%Y-%m-%d-%H%M')"/rcdefault
            echo -e "$Green"Backup completed"$Color_Off"
            echo
            echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; backups ;;
        2)
            echo
            echo
            echo -e "$Green"disk list:"$Color_Off"
            echo
            echo
            ls -1v /media/* | grep gp-backup | cat -n
            echo
            echo -e "$Green"
            echo
            read -p  "Select the disk where the backup is located  (corresponding number): " oper
            echo -e "$Color_Off"
            disk=$(ls -1v /media | cat -n | awk '{if(NR=='$oper') print $0}'| awk '{print $2}')
            if [[ $(findmnt -M "/media/$disk") ]]; then
                echo "The directory $disk has been mounted"
            else
                echo "The directory $disk is not mounted exit"
                exit 0
            fi
            echo -e "$Green"slect backup:"$Color_Off"
            echo
            echo
            ls -1v /media/$disk | cat -n
            echo
            read -p  "Select the disk where the backup is located  (corresponding number): " operr
            echo -e "$Color_Off"
            dir=$(ls -1v /media/$disk | cat -n | awk '{if(NR=='$operr') print $0}'| awk '{print $2}')
            cp -rp /media/$disk/"$dir"/* /etc/
            rm /etc/rcdefault
            for process in `cat /media/$disk/"$dir"/rcdefault` ; do
                f="$process"
                rc-update add "$f" default
            done
            echo -e "$Green"Restore completed"$Color_Off"
            echo
            echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; backups ;;
        3) menu ;;
        0) exit 0 ;;
        *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; selectk ;;
    esac
}
