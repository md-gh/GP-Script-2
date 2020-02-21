#!/bin/bash

. /opt/.gentooplayer/function/fcommands.sh

set -e

repeats=1
#text="I'm called"
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
        -l)
            quality="$2"
            shift # past argument
            ;;
        -z)
            treads="$2"
            shift # past argument
            ;;
        -m)
            sr="$2"
            shift # past argument
            ;;
        -n)
            bit="$2"
            shift # past argument
            ;;
        -o)
            channels="$2"
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
#echo "audiocardid = $audiocardid"


#read -p "Press enter to start writing to the Squeezelite-R2 configfile"

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
    echo "$quality" > /etc/default/web/mpd/quality
    echo "$sr" > /etc/default/web/mpd/sr
    echo "$bit" > /etc/default/web/mpd/bit
    echo "$channels" > /etc/default/web/mpd/channels
    echo "$treads" > /etc/default/web/mpd/treads
done

#echo "File content >> \n"
#cat "$filename" | grep --color=always -E "time=$time|card=$audiocardid|dsd='$dsd|minsr=$minsr|maxsr=$maxsr|btime=$btime|pcount=$pcount|sformat=$sformat|mmap=$mmap|ibuffer=$ibuffer|obuffer=$obuffer$"
#cat ~/"$filename" | grep --color=always -E "dsd='$dsd|$"

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

resampler {
plugin "soxr"
type "$quality"
threads "$treads"
}

audio_output {
  name "GP Mpd Soxr"
  type "alsa"
  device "$audiocardid"
  format "$sr:$bit:$channels"
  auto_resample "no"
  auto_format "no"
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
