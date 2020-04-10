#!/bin/bash

rm /tmp/upso &>/dev/null
if equery --quiet list squeezelite-R2 &>/dev/null; then
        echo "squeezelite-R2" >> /tmp/upso
fi
#
if equery --quiet list squeezelite &>/dev/null; then
        echo "squeezelite" >> /tmp/upso
fi
#
if equery --quiet list logitechmediaserver-bin &>/dev/null; then
        echo "logitechmediaserver-bin" >> /tmp/upso
fi
#
if equery --quiet list hqplayerd-bin &>/dev/null; then
        echo "hqplayerd-bin" >> /tmp/upso
fi
#
if equery --quiet list hqplayer-bin &>/dev/null; then
        echo "hqplayer-bin" >> /tmp/upso
fi
#
if equery --quiet list hqplayer4desktop-bin &>/dev/null; then
        echo "hqplayer4desktop-bin" >> /tmp/upso
fi
#
if equery --quiet list networkaudiod-bin &>/dev/null; then
        echo "networkaudiod-bin" >> /tmp/upso
fi
#
if equery --quiet list mympd &>/dev/null; then
        echo "mympd" >> /tmp/upso
fi
#
if equery --quiet list bubbleupnp-bin &>/dev/null; then
        echo "bubbleupnp-bin" >> /tmp/upso
fi
#
if equery --quiet list RoonBridge &>/dev/null; then
        echo "RoonBridge" >> /tmp/upso
fi
#
if equery --quiet list RoonServer &>/dev/null; then
        echo "RoonServer" >> /tmp/upso
fi
#
if equery --quiet list spotifyd-bin &>/dev/null; then
        echo "spotifyd-bin" >> /tmp/upso
fi
#
if equery --quiet list shairport-sync &>/dev/null; then
        echo "shairport-sync" >> /tmp/upso
fi
#
if equery --quiet list jriver-bin &>/dev/null; then
        echo "jriver-bin" >> /tmp/upso
fi
#
if equery --quiet list qobuz-desktop-player-bin &>/dev/null; then
        echo "qobuz-desktop-player-bin" >> /tmp/upso
fi
#
cat /tmp/upso
