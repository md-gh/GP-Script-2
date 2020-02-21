#!/bin/bash

#set -e

#repeats=1
#text="I'm called"
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            soft="$2"
            shift # past argument
            ;;
        -b)
            mode="$2"
            shift # past argument
            ;;
        -c)
            clea="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done




if [ "$mode" = "last" ]; then
    mue='tail -50'
fi

if [ "$mode" = "all" ]; then
    mue='cat'
fi

if [ "$mode" = "live" ]; then
    mue='tail -f'
fi

if [ "$soft" = "squeezelite" ]; then
    plog='/var/log/squeezelite.log'
fi

if [ "$soft" = "squeezelite-R2" ]; then
    plog='/var/log/squeezelite-R2.log'
fi

if [ "$soft" = "RoonBridge" ]; then
    plog='/root/.RoonBridge/Logs/RoonBridge_log.txt'
fi

if [ "$soft" = "RoonServer" ]; then
    plog='/root/.RoonServer/Logs/RoonServer_log.txt'
fi

if [ "$soft" = "squeezelite" ]; then
    plog='/var/log/squeezelite.log'
fi

if [ "$soft" = "squeezelite" ]; then
    plog='/var/log/squeezelite.log'
fi

if [ "$soft" = "Networkaudiod" ]; then
    plog='/var/log/networkaudiod.log'
fi

if [ "$soft" = "LMS Perform" ]; then
    plog='/var/log/logitechmediaserver/perfmon.log'
fi

if [ "$soft" = "LMS Scanner" ]; then
    plog='/var/log/logitechmediaserver/scanner.log'
fi

if [ "$soft" = "LMS Server" ]; then
    plog='/var/log/logitechmediaserver/server.log'
fi

if [ "$soft" = "Mpd" ]; then
    plog='/var/lib/mpd/log'
fi

if [ "$soft" = "Mpd_Sima" ]; then
    plog='/var/log/mpd-sima.log'
fi

if [ "$soft" = "Upmpdcli" ]; then
    plog='/var/log/upmpdcli.log'
fi

if [ "$soft" = "BubbleUpnp" ]; then
    plog='/var/log/bubbleupnp.log'
fi


$mue $plog 2>/dev/null

if [ "$clea" = "yes" ]; then
    true > $plog 2>/dev/null
fi
