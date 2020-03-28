#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            gpv="$2"
            shift # past argument
            ;;
        -b)
            disk="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done


cd /tmp

#rm -r * &>/dev/null
#Embedded BIOS
gpeb="https://drive.google.com/file/d/15d4NVMHOnS101Um5gIBbBCQs4o-afdVP/view?usp=sharing"
#Embedded UEFI
gpeu="https://drive.google.com/file/d/1iMN4drYfom-J5BoB07Y5nohTgkSLr6dL/view?usp=sharing"
#Xfce4 BIOS
gpxb="https://drive.google.com/file/d/1YhvHcViDDgr3ZlZUTZMLGtFU-e3NG7ZH/view?usp=sharing"
#Xfce4 UEFI
gpxu="https://drive.google.com/file/d/1dGOcvEgg0zyJn4PALnlSjcRMCxPrB0Tt/view?usp=sharing"
#Rpi3
gprpi3="https://drive.google.com/file/d/1y3ittLshOxfaWe5g7aSozGH65kje_tVM/view?usp=sharing"
#Rpi4
gprpi4="https://drive.google.com/file/d/1Z0d76RB_ScMqUPgH_SNt3oXzWuZHTP7h/view?usp=sharing"

git clone https://github.com/circulosmeos/gdown.pl.git

cd gdown.pl

case $gpv in
    GP-Embedded-BIOS)
        ./gdown.pl $gpeb gp.img.xz
        ;;
    GP-Embedded-UEFI)
        ./gdown.pl $gpeu gp.img.xz
        ;;
    GP-Xfce4-BIOS)
        ./gdown.pl $gpxb gp.img.xz
        ;;
    GP-xfce4-UEFI)
        ./gdown.pl $gpxu gp.img.xz
        ;;
    Rpi3)
        ./gdown.pl $gprpi3 gp.img.xz
        ;;
    Rpi3)
        ./gdown.pl $gprpi4 gp.img.xz
        ;;
esac

diskk=$(echo "$disk" | awk '{print $1}')

echo "wait...copy image"

xzcat gp.img.xz | dd of=/dev/$diskk
echo "wait..."
sleep 150

case $gpv in
    GP-Embedded-UEFI)
        echo
        echo
        echo "repair GPT"
        echo "type <w> at the first question"
        echo "type <Y> to the following questions - attention is a Y butch"
        echo -e "press ENTER to continue" ; read -n1
        echo
        echo
        echo
        gdisk /dev/$diskk
        ;;
    GP-xfce4-UEFI)
        echo
        echo
        echo "repair GPT"
        echo "type <w> at the first question"
        echo "type <Y> to the following questions - attention is a Y butch"
        echo -e "press ENTER to continue" ; read -n1
        echo
        echo
        echo
        gdisk /dev/$diskk
        ;;
esac

echo
echo
echo
echo "GentooPlayer is ben installed on $diskk"
echo
echo
echo
