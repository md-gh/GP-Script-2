#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -c)
            ips="$2"
            shift # past argument
            ;;
        -d)
            types="$2"
            shift # past argument
            ;;
        -o)
            options="$2"
            shift # past argument
            ;;
        -g)
            nameshare="$2"
            shift # past argument
            ;;
        -h)
            mntf="$2"
            shift # past argument
            ;;
        -i)
            user="$2"
            shift # past argument
            ;;
        -l)
            psw="$2"
            shift # past argument
            ;;
        -m)
            enableb="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

if [ ${#options} -eq 0 ]; then
    optionss=""
else
    optionss="$options"","
fi

if [ "$psw" = "NULL" ]; then
    psww=""
else
    psww="password="$psw","
fi

if [ "$user" = "guest" ]; then
    userr="guest"
else
    userr="username="$user","
fi



case $types in

    cifs)
        if  mount | grep /mnt/samba/$mntf; then
            echo ""
            echo  "A share is already mounted on /mnt/samba/$mntf"
        else
            mkdir -p /mnt/samba/$mntf
            chmod -R 777 /mnt/samba/$mntf
            mount -w -t cifs -o "$optionss""$userr""$psww" //$ips/$nameshare /mnt/samba/$mntf
            echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            echo -e "\e[38;5;82mIt has been mounted in /mnt/samba/$mntf\e[0m"
        fi
        if [ "$enableb" = "enable" ]; then
            echo "//$ips/$nameshare /mnt/samba/$mntf cifs "$optionss""$userr""$psww" 0 0" >> /etc/fstab
            echo -e "\n \e[38;5;154m[OK add to fstab]\e[0m\n"
        else
            echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
        fi
        ;;
    nfs)
        if  mount | grep /mnt/samba/$mntf; then
            echo ""
            echo  "A share is already mounted on /mnt/samba/$mntf"
        else
            mkdir -p /mnt/samba/$mntf
            chmod -R 777 /mnt/samba/$mntf
            mount -t nfs "$ips":/"$nameshare" /mnt/samba/$mntf -o "$optionss"
            echo -e "\n \e[38;5;154m[OK]\e[0m\n"
            echo -e "\e[38;5;82mIt has been mounted in /mnt/samba/$mntf\e[0m"
        fi
        if [ "$enableb" = "enable" ]; then
            echo ""$ips":/"$nameshare" /mnt/samba/$mntf nfs "$optionss" 0 0" >> /etc/fstab
            echo -e "\n \e[38;5;154m[OK add to fstab]\e[0m\n"
        else
            echo -e "\n \e[38;5;197m[NOT AT BOOT]\e[0m\n"
        fi
        ;;
esac
