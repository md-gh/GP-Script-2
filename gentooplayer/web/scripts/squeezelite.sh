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
        -A)
            resample="$2"
            shift # past argument
            ;;
        -B)
            quality="$2"
            shift # past argument
            ;;
        -C)
            phase="$2"
            shift # past argument
            ;;
        -D)
            resampleb="$2"
            shift # past argument
            ;;
        -E)
            mode="$2"
            shift # past argument
            ;;
        -F)
            flags="$2"
            shift # past argument
            ;;
        -G)
            attenuation="$2"
            shift # past argument
            ;;
        -H)
            precision="$2"
            shift # past argument
            ;;
        -L)
            passb="$2"
            shift # past argument
            ;;
        -M)
            passs="$2"
            shift # past argument
            ;;
        -N)
            passr="$2"
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
    echo "$time" > /etc/default/web/squeezelite/time
    echo "$enable" > /etc/default/web/squeezelite/enable
    echo "$audiocard" > /etc/default/web/squeezelite/card
    echo "$dsd" > /etc/default/web/squeezelite/dsd
    echo "$minsr" > /etc/default/web/squeezelite/minsr
    echo "$maxsr" > /etc/default/web/squeezelite/maxsr
    echo "$btime" > /etc/default/web/squeezelite/btime
    echo "$pcount" > /etc/default/web/squeezelite/pcount
    echo "$sformat" > /etc/default/web/squeezelite/sformat
    echo "$mmap" > /etc/default/web/squeezelite/mmap
    echo "$ibuffer" > /etc/default/web/squeezelite/ibuffer
    echo "$obuffer" > /etc/default/web/squeezelite/obuffer
    echo "$log" > /etc/default/web/squeezelite/log
    echo "$mac" > /etc/default/web/squeezelite/mac
    echo "$alsap" > /etc/default/web/squeezelite/alsap
    echo "$resample" > /etc/default/web/squeezelite/resample
    echo "$quality" > /etc/default/web/squeezelite/quality
    echo "$phase" > /etc/default/web/squeezelite/phase
    echo "$resampleb" > /etc/default/web/squeezelite/resampleb
    echo "$mode" > /etc/default/web/squeezelite/mode
    echo "$flags" > /etc/default/web/squeezelite/flags
    echo "$attenuation" > /etc/default/web/squeezelite/attenuation
    echo "$precision" > /etc/default/web/squeezelite/precision
    echo "$passb" > /etc/default/web/squeezelite/passb
    echo "$passs" > /etc/default/web/squeezelite/passs
    echo "$passr" > /etc/default/web/squeezelite/passr
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
if [ "$resample" = "enable" ]; then
    resamplerr="-R "$quality""$phase""$resampleb""$mode":"$flags":"$attenuation":"$precision":"$passb":"$passs":"$passr""
else
    resamplerr=""
fi

cat > /etc/conf.d/squeezelite <<EOF
SL_OPTS="-C $time -W $dsdd -o $audiocardid -r $minsr-$maxsr $alsapp $buffer $resamplerr $log -n GentooPlayer -m 00:f0:4c:68:d1:$mac"
EOF


/etc/init.d/squeezelite restart 2>/dev/null

echo
echo

sleep 2
audio
