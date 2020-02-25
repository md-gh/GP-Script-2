#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh

mympd --version | sed -n 1p > /tmp/mympdv

versionat=6.2.0
versioninst=$(cat /tmp/mympdv | awk '{print $2}')

if [ "$versionat" == "$versioninst" ]; then
    echo -e "$BRed mympd is already updated$Color_Off"
else
    cd /tmp
    rm -r *
    wget https://github.com/jcorporation/myMPD/archive/v$versionat.zip
    unzip v$versionat.zip
    cd myMPD-$versionat
    ./build.sh release
    ./build.sh install
    echo -e "$BGreen has been updated to the version:"$versionat"$Color_Off"
fi
