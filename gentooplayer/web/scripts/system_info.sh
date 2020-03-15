#!/bin/bash
. /opt/.gentooplayer/function/fcommands.sh

rammode=$(grep "#Mode" /etc/default/ramdisk.sh 2>/dev/null | sed 's/\#//g')
total=$(free -m | grep -E "^Mem:" | awk '{print $2}')
fmem=$(free -m | grep -E "^Mem:" | awk '{print $NF}')
profile=$(grep "#Profile" /etc/local.d/profile* 2>/dev/null | sed 's/\#//g')
#mini
clear
figlet -f big "GentooPlayer"

if
grep "#Profile" /etc/local.d/profile* 2>/dev/null; then
    echo -e "\033[31;1m Profile: \e[0m    \033[32;1m$profile\e[0m"
else
    echo -e "\033[31;1m Profile: \e[0m    \033[31;1mProfile not Setting\e[0m"
fi
if
mount -l | grep "none on /etc type tmpfs"  1>/dev/null; then
    echo -e " \033[31;1mRamSystem:\e[0m   \033[32;1m"$rammode"\e[0m"
else
    echo -e " \033[31;1mRamSystem:\e[0m   \033[31;1mRamsystem not enabled\e[0m"
fi
echo -e " \033[32;1mFree memory:\e[0m ${fmem}MB of total ${total}MB"
echo
tmp=$(uname -r)
echo -e "\033[31;1m Kernel: \e[0m  \033[1m$tmp\033[0m"
/opt/.gentooplayer/GentooPlayer/gentooplayer/func/obtain_network_details
/opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-banner 0

echo
echo -e "\033[1mPlayers Info:\e[0m"

if
rc-update show -v | grep squeezelite-R2 | grep default 1>/dev/null; then
    echo -e "Squeezelite-R2          [\033[32;1mEnabled\e[0m]"
else
    echo -e "Squeezelite-R2          [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | egrep -w "squeezelite " | grep default 1>/dev/null; then
    echo -e "Squeezelite             [\033[32;1mEnabled\e[0m]"
else
    echo -e "Squeezelite             [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep networkaudiod | grep default 1>/dev/null; then
    echo -e "Networkaudiod           [\033[32;1mEnabled\e[0m]"
else
    echo -e "Networkaudiod           [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep logitechmediaserver | grep default 1>/dev/null; then
    echo -e "LogitechMediaServre     [\033[32;1mEnabled\e[0m]"
else
    echo -e "LigitechMediaServer     [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep bubbleupnp | grep default 1>/dev/null; then
    echo -e "BubbleUpnp              [\033[32;1mEnabled\e[0m]"
else
    echo -e "BubbleUpnp              [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep hqplayerd | grep default 1>/dev/null; then
    echo -e "HQPlayer Embedded       [\033[32;1mEnabled\e[0m]"
else
    echo -e "HQPlayer Embedded       [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep mpd | grep default 1>/dev/null; then
    echo -e "Mpd                     [\033[32;1mEnabled\e[0m]"
else
    echo -e "Mpd                     [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep upmpdcli | grep default 1>/dev/null; then
    echo -e "UpMpdCli                [\033[32;1mEnabled\e[0m]"
else
    echo -e "UpMpdCli                [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep roonbridge | grep default 1>/dev/null; then
    echo -e "RoonBridge              [\033[32;1mEnabled\e[0m]"
else
    echo -e "RoonBridge              [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep roonserver | grep default 1>/dev/null; then
    echo -e "RoonServer              [\033[32;1mEnabled\e[0m]"
else
    echo -e "RoonServer              [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep mpd-sima | grep default 1>/dev/null; then
    echo -e "Mpd-Sima                [\033[32;1mEnabled\e[0m]"
else
    echo -e "Mpd-Sima                [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep mympd | grep default 1>/dev/null; then
    echo -e "MYmpd                   [\033[32;1mEnabled\e[0m]"
else
    echo -e "MYmpd                   [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep minimserver | grep default 1>/dev/null; then
    echo -e "minimserver             [\033[32;1mEnabled\e[0m]"
else
    echo -e "minimserver             [\033[31;1mDisabled\e[0m]"
fi

if
rc-update show -v | grep shairport-sync | grep default 1>/dev/null; then
    echo -e "shairport-sync             [\033[32;1mEnabled\e[0m]"
else
    echo -e "shairport-sync             [\033[31;1mDisabled\e[0m]"
fi

echo
alsacap

echo
echo
audio 2>/dev/null

echo
echo

df -T -h

#echo -e "\033[1mService Status:\e[0m"
#rc-status default boot
##
#echo
#echo



#echo -e "\033[1mVersion software:\e[0m"

#equery --quiet list alsa-lib
#equery --quiet list squeezelite-R2
#equery --quiet list squeezelite
#equery --quiet list logitechmediaserver-bin
#equery --quiet list hqplayerd-bin
#equery --quiet list hqplayer-bin
#equery --quiet list hqplayer4desktop-bin
#equery --quiet list media-sound/mpd
#equery --quiet list upmpdcli
#equery --quiet list dev-lang/perl
#echo "media-sound/RoonBridge-$(cat /opt/RoonBridge/VERSION | awk NR==2)"

#if [ -f "/opt/RoonServer/VERSION" ]
#then
#    echo "media-sound/RoonServer-$(cat /opt/RoonServer/VERSION | awk NR==2)"
#fi


echo
echo

cpu-info
