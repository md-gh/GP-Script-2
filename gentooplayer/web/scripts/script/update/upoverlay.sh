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

cat /tmp/upso
