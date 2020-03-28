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


. /opt/.gentooplayer/function/fcommands.sh
. /opt/.gentooplayer/function/fcolors.sh
if grep -Fxq "$command" "/etc/default/web/command"; then
    echo ";-)"
else
    echo "$command" >> "/etc/default/web/command"
fi

$command 2>/dev/null
$ccommand 2>/dev/nul
