#!/bin/bash
echo
echo

. /opt/.gentooplayer/function/fcolors.sh

lms=$(emerge --search "%logitechmediaserver-bin$" | grep 'media-sound/logitechmediaserver-bin\|Latest version available:\|Latest version installed:')
#emerge --search "%logitechmediaserver-bin$" | grep 'media-sound/logitechmediaserver-bin\|Latest version available:\|Latest version installed:'
echo "$lms"
