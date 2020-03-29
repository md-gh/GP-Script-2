#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh
echo
echo
/opt/.gentooplayer/script/gp-update0.sh &>/dev/null

echo -e "$BRed LogitechMediaServer$color_off"
soft=$(emerge --search "%logitechmediaserver-bin$" 2>/dev/null | grep 'media-sound/logitechmediaserver-bin\|Latest version available:\|Latest version installed:')
#emerge --search "%logitechmediaserver-bin$" | grep 'media-sound/logitechmediaserver-bin\|Latest version available:\|Latest version installed:'
echo "$soft"
echo
echo -e "$BRed Squeezelite$color_off"
soft=$(emerge --search "%squeezelite$" 2>/dev/null | grep 'media-sound/squeezelite\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Squeezelite-R2$color_off"
soft=$(emerge --search "%squeezelite-R2$" 2>/dev/null | grep 'media-sound/squeezelite-R2\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Networkaudiod$color_off"
soft=$(emerge --search "%networkaudiod-bin$" 2>/dev/null | grep 'media-sound/networkaudiod-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed BubbleUpnp$color_off"
soft=$(emerge --search "%bubbleupnp-bin$" 2>/dev/null | grep 'net-misc/bubbleupnp-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed HQPlayer Embedded$color_off"
soft=$(emerge --search "%hqplayerd-bin$" 2>/dev/null | grep 'media-sound/hqplayerd-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Mpd$color_off"
soft=$(emerge --search "%media-sound/mpd$" 2>/dev/null | grep 'media-sound/mpd\|Latest version available:\|Latest version installed:')
echo "$soft"
