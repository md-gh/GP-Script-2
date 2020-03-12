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

rm -r * 2>/dev/null

gpeb="https://drive.google.com/file/d/15d4NVMHOnS101Um5gIBbBCQs4o-afdVP/view?usp=sharing"
gpeu="https://drive.google.com/file/d/1iMN4drYfom-J5BoB07Y5nohTgkSLr6dL/view?usp=sharing"
gpxb="https://drive.google.com/file/d/1YhvHcViDDgr3ZlZUTZMLGtFU-e3NG7ZH/view?usp=sharing"
gpxu="https://drive.google.com/file/d/1dGOcvEgg0zyJn4PALnlSjcRMCxPrB0Tt/view?usp=sharing"

#git clone https://github.com/circulosmeos/gdown.pl.git

#cd gdown.pl

#case $gpv in
#  GP-Embedded-BIOS)
#  ./gdown.pl $gpeb gp.img.xz
#  ;;
#  GP-Embedded-UEFI)
#  ./gdown.pl $gpeu gp.img.xz
#  ;;
#  GP-Xfce4-BIOS)
#  ./gdown.pl $gpxb gp.img.xz
#  ;;
#  GP-xfce4-UEFI)
#  ./gdown.pl $gpxu gp.img.xz
#  ;;
#esac

diskk=$(echo "$disk" | awk '{print $1}')

echo "$diskk"
