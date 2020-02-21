#!/bin/bash
. /opt/.gentooplayer/function/fcommands.sh

set -e

repeats=1
#text="I'm called"
filename='/etc/conf.d/squeezelite-R2-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            time="$2"
            shift # past argument
            ;;
        -t)
            audiocard="$2"
            shift # past argument
            ;;
        -d)
            dsd="$2"
            shift # past argument
            ;;
        -r)
            minsr="$2"
            shift # past argument
            ;;
        -R)
            maxsr="$2"
            shift # past argument
            ;;
        -b)
            btime="$2"
            shift # past argument
            ;;
        -p)
            pcount="$2"
            shift # past argument
            ;;
        -s)
            sformat="$2"
            shift # past argument
            ;;
        -u)
            mmap="$2"
            shift # past argument
            ;;
        -i)
            ibuffer="$2"
            shift # past argument
            ;;
        -o)
            obuffer="$2"
            shift # past argument
            ;;
        -g)
            log="$2"
            shift # past argument
            ;;
        -h)
            mac="$2"
            shift # past argument
            ;;
        -I)
            alsap="$2"
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
for (( i=0; i<repeats ; i++ ))
do
    echo "$time" > /etc/default/web/R2/time
    echo "$enable" > /etc/default/web/R2/enable
    echo "$audiocard" > /etc/default/web/R2/card
    echo "$dsd" > /etc/default/web/R2/dsd
    echo "$minsr" > /etc/default/web/R2/minsr
    echo "$maxsr" > /etc/default/web/R2/maxsr
    echo "$btime" > /etc/default/web/R2/btime
    echo "$pcount" > /etc/default/web/R2/pcount
    echo "$sformat" > /etc/default/web/R2/sformat
    echo "$mmap" > /etc/default/web/R2/mmap
    echo "$ibuffer" > /etc/default/web/R2/ibuffer
    echo "$obuffer" > /etc/default/web/R2/obuffer
    echo "$log" > /etc/default/web/R2/log
    echo "$mac" > /etc/default/web/R2/mac
    echo "$alsap" > /etc/default/web/R2/alsap
done



if [ "$log" = "info" ]; then
    log='-d all=info'
fi;

if [ "$log" = "debug" ]; then
    log='-d all=debug'
fi;

if [ ${#ibuffer} -eq 0 ]; then
    buffer=""
else
    buffer="-b $ibuffer:$obuffer"
fi

if [ ${#dsd} -eq 0 ]; then
    dsdd=""
else
    dsdd="$dsd"
fi

if [ "$alsap" = "enable" ]; then
    alsapp="-a $btime:$pcount:$sformat:$mmap"
else
    alsapp=""
fi

cat > /etc/conf.d/squeezelite-R2 <<EOF
SL_OPTS="-C $time $dsdd -o $audiocardid -r $minsr-$maxsr $alsapp $buffer $log -n GentooPlayer-R2 -m 00:e0:4s:78:d1:$mac"
EOF


/etc/init.d/squeezelite-R2 restart 2>/dev/null

echo
echo

sleep 2
audio
