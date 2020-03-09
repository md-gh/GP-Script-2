#!/bin/bash
. /opt/.gentooplayer/function/fcommands.sh

set -e

repeats=1
filename='/etc/conf.d/mpdbp-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -b)
            audiocard="$2"
            shift # past argument
            ;;
        -c)
            mmap="$2"
            shift # past argument
            ;;
        -d)
            btime="$2"
            shift # past argument
            ;;
        -e)
            btimev="$2"
            shift # past argument
            ;;
        -f)
            ptime="$2"
            shift # past argument
            ;;
        -g)
            ptimev="$2"
            shift # past argument
            ;;
        -h)
            mixtype="$2"
            shift # past argument
            ;;
        -i)
            abuffer="$2"
            shift # past argument
            ;;
        -t)
            dsd="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done


card=$(echo $audiocard | awk '{print $2}' | sed 's/\://g')
cardid=$(cat /proc/asound/card$card/id)
dev=$(cat /proc/asound/card$card/pcm0p/info | awk 'NR==2' | awk '{print $2}')
audiocardid="hw:CARD=$cardid,DEV=$dev"


for (( i=0; i<repeats ; i++ ))
do
    echo "$audiocard" > /etc/default/web/mpd/card
    echo "$mmap" > /etc/default/web/mpd/mmap
    echo "$mixtype" > /etc/default/web/mpd/mixtipe
    echo "$abuffer" > /etc/default/web/mpd/abuffer
    echo "$btime" > /etc/default/web/mpd/buffert
    echo "$btimev" > /etc/default/web/mpd/buffertv
    echo "$ptime" > /etc/default/web/mpd/ptime
    echo "$ptimev" > /etc/default/web/mpd/ptimev
    echo "$dsd" > /etc/default/web/mpd/dsd
done



if [ "$enable" = "enable" ]; then
    rc-update add mpd default 2>/dev/null
fi

if [ "$enable" = "disable" ]; then
    rc-update delete mpd default 2>/dev/null
fi

if [ "$btime" = "enable" ]; then
    btimem='buffer_time ''"'"$btimev"'"'
fi

if [ "$ptime" = "enable" ]; then
    ptimem='period_time ''"'"$ptimev"'"'
fi
if [ "$dsd" = "DOP" ]; then
    dsdd='dsd' 'yes'
fi

cat > /etc/mpd.conf <<EOF
#. /etc/conf.d/mpdbf-conf

music_directory			"/var/lib/mpd/music"
playlist_directory		"/var/lib/mpd/playlists"
db_file			"/var/lib/mpd/database"
log_file			"/var/lib/mpd/log"
pid_file			"/var/lib/mpd/pid"
state_file			"/var/lib/mpd/state"
#log_level "verbose"

user				"mpd"
bind_to_address		"any"

input {
        plugin "curl"
        enabled	"yes"
#       proxy "proxy.isp.com:8080"
#       proxy_user "user"
#       proxy_password "password"
}

audio_output {
  type "alsa"
  name "GP Mpd BitPerfect"
  device "$audiocardid"
  enabled "yes"
  use_mmap  "$mmap"
  $btimem
  $ptimem
}

mixer_type   "$mixtype"

filesystem_charset  "UTF-8"

audio_buffer_size  "$abuffer"
EOF


/etc/init.d/mpd restart 2>/dev/null

echo
echo

sleep 2
audio
