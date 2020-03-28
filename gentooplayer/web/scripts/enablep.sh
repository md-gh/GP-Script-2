#!/bin/bash

#set -e

#repeats=1
#text="I'm called"
#filename='/etc/conf.d/mpdbp-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            sq2="$2"
            shift # past argument
            ;;
        -b)
            sq="$2"
            shift # past argument
            ;;
        -c)
            nad="$2"
            shift # past argument
            ;;
        -d)
            lms="$2"
            shift # past argument
            ;;
        -e)
            bub="$2"
            shift # past argument
            ;;
        -f)
            hqpe="$2"
            shift # past argument
            ;;
        -g)
            mpd="$2"
            shift # past argument
            ;;
        -h)
            upm="$2"
            shift # past argument
            ;;
        -i)
            roonb="$2"
            shift # past argument
            ;;
        -l)
            roons="$2"
            shift # past argument
            ;;
        -m)
            mpds="$2"
            shift # past argument
            ;;
        -n)
            mympd="$2"
            shift # past argument
            ;;
        -o)
            web="$2"
            shift # past argument
            ;;
        -p)
            mserver="$2"
            shift # past argument
            ;;
        -q)
            shair="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done


if [ "$sq2" = "enable" ]; then
    rc-update add squeezelite-R2 default 2>/dev/null
    rc-service squeezelite-R2 restart 2>/dev/null
else
    rc-update del squeezelite-R2 default 2>/dev/null
fi
#
if [ "$sq" = "enable" ]; then
    rc-update add squeezelite default 2>/dev/null
    rc-service squeezelite restart 2>/dev/null
else
    rc-update del squeezelite default 2>/dev/null
fi
#
if [ "$nad" = "enable" ]; then
    rc-update add networkaudiod default 2>/dev/null
    rc-service networkaudiod restart 2>/dev/null
else
    rc-update del networkaudiod default 2>/dev/null
fi
#
if [ "$lms" = "enable" ]; then
    rc-update add logitechmediaserver default 2>/dev/null
    rc-service logitechmediaserver restart 2>/dev/null
else
    rc-update del logitechmediaserver default 2>/dev/null
fi

if [ "$bub" = "enable" ]; then
    rc-update add bubbleupnp default 2>/dev/null
    rc-service bubbleupnp restart 2>/dev/null
else
    rc-update del bubbleupnp default 2>/dev/null
fi
#
if [ "$hqpe" = "enable" ]; then
    rc-update add hqplayerd default 2>/dev/null
    rc-service hqplayerd restart 2>/dev/null
else
    rc-update del hqplayerd default 2>/dev/null
fi
#
if [ "$mpd" = "enable" ]; then
    rc-update add mpd default 2>/dev/null
    rc-service mpd restart 2>/dev/null
else
    rc-update del mpd default 2>/dev/null
fi
#
if [ "$upm" = "enable" ]; then
    rc-update add upmpdcli default 2>/dev/null
    rc-service upmpdcli restart 2>/dev/null
else
    rc-update del upmpdcli default 2>/dev/null
fi
#
if [ "$roonb" = "enable" ]; then
    rc-update add roonbridge default 2>/dev/null
    rc-service roonbridge restart 2>/dev/null
else
    rc-update del roonbridge default 2>/dev/null
fi
#
if [ "$roons" = "enable" ]; then
    rc-update add roonserver default 2>/dev/null
    rc-service roonserver restart 2>/dev/null
else
    rc-update del roonserver default 2>/dev/null
fi
#
if [ "$mpds" = "enable" ]; then
    rc-update add mpd-sima default 2>/dev/null
    rc-service mpd-sima restart 2>/dev/null
else
    rc-update del mpd-sima default 2>/dev/null
fi
#
if [ "$mympd" = "enable" ]; then
    rc-update add mympd default 2>/dev/null
    rc-service mympd restart 2>/dev/null
else
    rc-update del mympd default 2>/dev/null
fi
#
if [ "$mserver" = "enable" ]; then
    rc-update add minimserver default 2>/dev/null
    rc-service minimserver restart 2>/dev/null
else
    rc-update del minimserver default 2>/dev/null
fi
#
if [ "$shair" = "enable" ]; then
    rc-update add shairport-sync default 2>/dev/null
    rc-service shairport-sync restart 2>/dev/null
else
    rc-update del shairport-sync default 2>/dev/null
fi
#
if [ "$web" = "enable" ]; then
    rc-update add web default 2>/dev/null
    #rc-service web restart 2>/dev/null
else
    rc-update del web default 2>/dev/null
fi
