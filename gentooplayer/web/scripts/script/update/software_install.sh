#!/bin/bash

rm /tmp/upsi &>/dev/null
if ! equery --quiet list media-sound/mpd &>/dev/null; then
        echo "media-sound/mpd" >> /tmp/upsi
fi
#
if ! equery --quiet list upmpdcli &>/dev/null; then
        echo "upmpdcli" >> /tmp/upsi
fi
#
if ! equery --quiet list squeezelite-R2 &>/dev/null; then
        echo "squeezelite-R2" >> /tmp/upsi
fi
#
if ! equery --quiet list squeezelite &>/dev/null; then
        echo "squeezelite" >> /tmp/upsi
fi
#
if ! equery --quiet list logitechmediaserver-bin &>/dev/null; then
        echo "logitechmediaserver-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list hqplayerd-bin &>/dev/null; then
        echo "hqplayerd-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list hqplayer-bin &>/dev/null; then
        echo "hqplayer-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list hqplayer4desktop-bin &>/dev/null; then
        echo "hqplayer4desktop-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list networkaudiod-bin &>/dev/null; then
        echo "networkaudiod-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list mympd &>/dev/null; then
        echo "mympd" >> /tmp/upsi
fi
#
if ! equery --quiet list bubbleupnp-bin &>/dev/null; then
        echo "bubbleupnp-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list RoonBridge &>/dev/null; then
        echo "RoonBridge" >> /tmp/upsi
fi
#
if ! equery --quiet list RoonServer &>/dev/null; then
        echo "RoonServer" >> /tmp/upsi
fi
#
if ! equery --quiet list spotifyd-bin &>/dev/null; then
        echo "spotifyd-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list shairport-sync &>/dev/null; then
        echo "shairport-sync" >> /tmp/upsi
fi
#
if ! equery --quiet list jriver-bin &>/dev/null; then
        echo "jriver-bin" >> /tmp/upsi
fi
#
if ! equery --quiet list qobuz-desktop-player-bin &>/dev/null; then
        echo "qobuz-desktop-player-bin" >> /tmp/upsi
fi
#
cat /tmp/upsi
