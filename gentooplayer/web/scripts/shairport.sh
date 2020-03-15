#!/bin/bash
. /opt/.gentooplayer/function/fcommands.sh

set -e

repeats=1
filename='/etc/conf.d/squeezelite-R2-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            audiocard="$2"
            shift # past argument
            ;;
        -b)
            mixername="$2"
            shift # past argument
            ;;
        -c)
            orate="$2"
            shift # past argument
            ;;
        -d)
            oformat="$2"
            shift # past argument
            ;;
        -e)
            sync="$2"
            shift # past argument
            ;;
        -f)
            psize="$2"
            shift # past argument
            ;;
        -g)
            bsize="$2"
            shift # past argument
            ;;
        -h)
            mmap="$2"
            shift # past argument
            ;;
        -i)
            timing="$2"
            shift # past argument
            ;;
        -l)
            stanby="$2"
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
    echo "$audiocard" > /etc/default/web/shairport/card
    echo "$mixername" > /etc/default/web/shairport/mixername
    echo "$orate" > /etc/default/web/shairport/orate
    echo "$oformat" > /etc/default/web/shairport/oformat
    echo "$sync" > /etc/default/web/shairport/sync
    echo "$psize" > /etc/default/web/shairport/psize
    echo "$bsize" > /etc/default/web/shairport/bsize
    echo "$mmap" > /etc/default/web/shairport/mmap
    echo "$timing" > /etc/default/web/shairport/timing
    echo "$stanby" > /etc/default/web/shairport/stanby
done

if [ ${#mixername} -eq 0 ]; then
    mixernamee=""
else
    mixernamee="mixer_control_name = "'"'""$mixername""'"'";"
fi

if [ "$orate" = "auto" ]; then
    oratee=""
  else
    oratee="output_rate = "$orate";"
fi

if [ "$oformat" = "auto" ]; then
    oformatt=""
  else
    oformatt="output_format = "'"'""$oformat""'"'";"
fi

syncc="disable_synchronization = "'"'""$sync""'"'";"

if [ ${#psize} -eq 0 ]; then
    psizee=""
else
    psizee="period_size = "$psize";"
fi

if [ ${#bsize} -eq 0 ]; then
    bsizee=""
else
    bsizee="buffer_size = "$bsize";"
fi

mmapp="use_mmap_if_available = "'"'""$mmap""'"'";"

if [ "$timing" = "auto" ]; then
    timingg=""
  else
    timingg="use_precision_timing = "'"'""$timing""'"'";"
fi

if [ "$stanby" = "auto" ]; then
    stanbyy=""
  else
    stanbyy="disable_standby_mode = "'"'""$stanby""'"'";"
fi

cat > /etc/shairport-sync.conf <<EOF
alsa =
{
output_device = "$audiocardid";
$mixernamee
$oratee
$oformatt
$syncc
$psizee
$bsizee
$mmapp
$timingg
$stanbyy
}
EOF


/etc/init.d/shairport-sync restart 2>/dev/null

echo
echo

sleep 2
audio
