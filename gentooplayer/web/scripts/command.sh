#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            command="$2"
            shift # past argument
            ;;
        -b)
            ccommand="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

#oper=$(awk '{print $1}' <<< "$alsav")

#alsasw=$(ls -1v /usr/portage/packages/media-libs/ | sed 's/.tbz2//' | sed 's/alsa-lib-//' | cat -n | awk '{if(NR=='$oper') print $0}' | awk '{print $2}')
#echo "$kernn"
. /opt/.gentooplayer/function/fcommands.sh
. /opt/.gentooplayer/function/fcolors.sh
if grep -Fxq $command "/etc/default/web/command"; then
    echo "ok"
else
    echo "$command" >> "/etc/default/web/command"
fi

$command 2>/dev/null && exit 0
$ccommand 2>/dev/nul && exit 0
