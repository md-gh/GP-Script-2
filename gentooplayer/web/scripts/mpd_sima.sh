#!/bin/bash
. /opt/.gentooplayer/function/fcommands.sh

#set -e

repeats=1
#text="I'm called"
filename='/etc/conf.d/mpdbp-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            quee="$2"
            shift # past argument
            ;;
        -b)
            maxa="$2"
            shift # past argument
            ;;
        -c)
            depth="$2"
            shift # past argument
            ;;
        -d)
            salbum="$2"
            shift # past argument
            ;;
        -e)
            track="$2"
            shift # past argument
            ;;
        -f)
            album="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done




for (( i=0; i<repeats ; i++ ))
do
    echo "$quee" > /etc/default/web/mpd-sima/quee
    echo "$maxa" > /etc/default/web/mpd-sima/maxa
    echo "$depth" > /etc/default/web/mpd-sima/depth
    echo "$salbum" > /etc/default/web/mpd-sima/salbum
    echo "$track" > /etc/default/web/mpd-sima/track
    echo "$album" > /etc/default/web/mpd-sima/album
done



sed -i '/queue_mode =/c\queue_mode = '"$quee"'' /opt/sima/mpd-sima.cfg
sed -i '/max_art =/c\max_art = '"$maxa"'' /opt/sima/mpd-sima.cfg
sed -i '/depth =/c\depth = '"$depth"'' /opt/sima/mpd-sima.cfg
sed -i '/single_album =/c\single_album = '"$salbum"'' /opt/sima/mpd-sima.cfg
sed -i '/track_to_add =/c\track_to_add = '"$track"'' /opt/sima/mpd-sima.cfg
sed -i '/album_to_add =/c\album_to_add = '"$album"'' /opt/sima/mpd-sima.cfg


/etc/init.d/mpd-sima restart 2>/dev/null
