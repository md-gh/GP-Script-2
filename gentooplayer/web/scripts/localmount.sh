#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -b)
            mntl="$2"
            shift # past argument
            ;;
        -c)
            dirn="$2"
            shift # past argument
            ;;
        -d)
            enab="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

UUID="$(lsblk -f | grep "$mntl" | awk '{ print $4 }')"
fstype="$(lsblk -f | grep "$mntl" | awk '{ print $2 }')"

case $fstype in

    ext4)
        if [[ $(findmnt -m /dev/"$mntl") ]]; then
            echo "This drive is already mounted on $(findmnt -m /dev/"$mntl" | awk '{ print $1 }')"
        else
            mkdir -p /media/$dirn
            chmod 777 /media/$dirn
            mount /dev/$mntl /media/$dirn
            if [[ $(findmnt -M "/media/$dirn") ]]; then
                echo "The ext4 partition /dev/$mntl has been mounted to /media/$dirn"
            else
                echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
                exit 0
            fi
            if [ "$enab" = "enable" ]; then
                echo "UUID="$UUID" /media/$dirn ext4 defaults 0 0" >> /etc/fstab
                echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            else
                echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
            fi
        fi
        ;;

    ext3)
        if [[ $(findmnt -m /dev/"$mntl") ]]; then
            echo "This drive is already mounted on $(findmnt -m /dev/"$mntl" | awk '{ print $1 }')"
        else
            mkdir -p /media/$dirn
            chmod 777 /media/$dirn
            mount /dev/$mntl /media/$dirn
            if [[ $(findmnt -M "/media/$dirn") ]]; then
                echo "The ext4 partition /dev/$mntl has been mounted to /media/$dirn"
            else
                echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
                exit 0
            fi
            if [ "$enab" = "enable" ]; then
                echo "UUID="$UUID" /media/$dirn ext3 defaults 0 0" >> /etc/fstab
                echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            else
                echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
            fi
        fi
        ;;

    ext2)
        if [[ $(findmnt -m /dev/"$mntl") ]]; then
            echo "This drive is already mounted on $(findmnt -m /dev/"$mntl" | awk '{ print $1 }')"
        else
            mkdir -p /media/$dirn
            chmod 777 /media/$dirn
            mount /dev/$mntl /media/$dirn
            if [[ $(findmnt -M "/media/$dirn") ]]; then
                echo "The ext4 partition /dev/$mntl has been mounted to /media/$dirn"
            else
                echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
                exit 0
            fi
            if [ "$enab" = "enable" ]; then
                echo "UUID="$UUID" /media/$dirn ext2 defaults 0 0" >> /etc/fstab
                echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            else
                echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
            fi
        fi
        ;;

    vfat)
        if [[ $(findmnt -m /dev/"$mntl") ]]; then
            echo "This drive is already mounted on $(findmnt -m /dev/"$mntl" | awk '{ print $1 }')"
        else
            mkdir -p /media/$dirn
            chmod 777 /media/$dirn
            mount /dev/$mntl /media/$dirn
            if [[ $(findmnt -M "/media/$dirn") ]]; then
                echo "The ext4 partition /dev/$mntl has been mounted to /media/$dirn"
            else
                echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
                exit 0
            fi
            if [ "$enab" = "enable" ]; then
                echo "UUID="$UUID" /media/$dirn vfat defaults 0 0" >> /etc/fstab
                echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            else
                echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
            fi
        fi
        ;;

    ntfs)
        if [[ $(findmnt -m /dev/"$mntl") ]]; then
            echo "This drive is already mounted on $(findmnt -m /dev/"$mntl" | awk '{ print $1 }')"
        else
            mkdir -p /media/$dirn
            chmod 777 /media/$dirn
            mount -t ntfs-3g /dev/$mntl /media/$dirn
            if [[ $(findmnt -M "/media/$dirn") ]]; then
                echo "The ext4 partition /dev/$mntl has been mounted to /media/$dirn"
            else
                echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
                exit 0
            fi
            if [ "$enab" = "enable" ]; then
                echo "UUID="$UUID" /media/$dirn ntfs-3g defaults 0 0" >> /etc/fstab
                echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            else
                echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
            fi
        fi
        ;;

esac
