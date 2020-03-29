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
soft=$(emerge --search "%media-sound/mpd$" 2>/dev/null | grep 'media-sound/mpd\|Latest version available:\|Latest version installed:' | sed '1d')
echo "$soft"
echo
echo -e "$BRed UpMpdCli$color_off"
soft=$(emerge --search "%upmpdcli$" 2>/dev/null | grep 'media-sound/upmpdcli\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed RoonBridge$color_off"
soft=$(emerge --search "%RoonBridge$" 2>/dev/null | grep 'media-sound/RoonBridge\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed RoonServer$color_off"
soft=$(emerge --search "%RoonServer$" 2>/dev/null | grep 'media-sound/RoonServer\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed RoonServer$color_off"
soft=$(emerge --search "%RoonServer$" 2>/dev/null | grep 'media-sound/RoonServer\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed MyMpd$color_off"
soft=$(emerge --search "%mympd$" 2>/dev/null | grep 'media-sound/mympd\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Shairport-Sync$color_off"
soft=$(emerge --search "%shairport-sync$" 2>/dev/null | grep 'media-sound/shairport-sync\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Hqplayer-Desktop3$color_off"
soft=$(emerge --search "%hqplayer-bin$" 2>/dev/null | grep 'media-sound/hqplayer-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Hqplayer-Desktop4$color_off"
soft=$(emerge --search "%hqplayer4desktop-bin$" 2>/dev/null | grep 'media-sound/hqplayer4desktop-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Jriver$color_off"
soft=$(emerge --search "%jriver-bin$" 2>/dev/null | grep 'media-sound/jriver-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
echo
echo -e "$BRed Qobuz-Desktop$color_off"
soft=$(emerge --search "%qobuz-desktop-player-bin$" 2>/dev/null | grep 'media-sound/qobuz-desktop-player-bin\|Latest version available:\|Latest version installed:')
echo "$soft"
