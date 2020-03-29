#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh
echo
echo
/opt/.gentooplayer/script/gp-update0.sh &>/dev/null

echo -e "$BRed LogitechMediaServer$color_off"
lms=$(emerge --search "%logitechmediaserver-bin$" 2>/dev/null | grep 'media-sound/logitechmediaserver-bin\|Latest version available:\|Latest version installed:')
#emerge --search "%logitechmediaserver-bin$" | grep 'media-sound/logitechmediaserver-bin\|Latest version available:\|Latest version installed:'
echo "$lms"
echo
echo -e "$BRed Squeezelite$color_off"
sqeeze=$(emerge --search "%squeezelite$" 2>/dev/null | grep 'media-sound/squeezelite\|Latest version available:\|Latest version installed:')
echo "$sqeeze"
echo
echo -e "$BRed Squeezelite-R2$color_off"
sqeeze2=$(emerge --search "%squeezelite-R2$" 2>/dev/null | grep 'media-sound/squeezelite-R2\|Latest version available:\|Latest version installed:')
echo "$sqeeze2"
echo
echo -e "$BRed Networkaudiod$color_off"
nad=$(emerge --search "%networkaudiod-bin$" 2>/dev/null | grep 'media-sound/networkaudiod-bin\|Latest version available:\|Latest version installed:')
echo "$nad"
