#!/bin/bash

#set -e

repeats=1
#text="I'm called"
#filename='/etc/conf.d/mpdbp-conf'
#clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            usoft="$2"
            shift # past argument
            ;;
        -b)
            rsoft="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

if [ "$usoft" = "GentooPlayer_gp-update" ]; then
    /opt/.gentooplayer/script/gp-update.sh && echo "GentooPlayer is Update"
    /etc/init.d/web restart
    exit 0
fi

/opt/.gentooplayer/script/gp-update0.sh

if [ ${#usoft} -eq 0 ]; then
    echo "ok"
else
    emerge --sync
fi


case $usoft in
    Squeezelite-R2)
        if equery --quiet list squeezelite-R2; then
            if emerge -p squeezelite-R2 | egrep -w "U"; then
                echo "update squeezelite-R2...please wait...."
                emerge squeezelite-R2
            else
                echo "Squeezelite-R2 is already updated"
            fi
        else
            echo "Squeezelite-R2 is not installed on this system"
        fi
        ;;
    Squeezelite)
        if equery --quiet list squeezelite; then
            if emerge -p squeezelite | egrep -w "U"; then
                echo "update squeezelite...please wait...."
                emerge squeezelite
            else
                echo "Squeezelite-R2 is already updated"
            fi
        else
            echo "Squeezelite-R2 is not installed on this system"
        fi
        ;;
    LogitechMediaServer)
        if equery --quiet list logitechmediaserver-bin; then
            if emerge -p logitechmediaserver-bin | egrep -w "U"; then
                echo "update LogitechMediaServer...please wait...."
                emerge logitechmediaserver-bin
            else
                echo "LogitechMediaServer is already updated"
            fi
        else
            echo "LogitechMediaServer is not installed on this system"
        fi
        ;;
    HQPlayerEmbedded)
        if equery --quiet list hqplayerd-bin; then
            if emerge -p hqplayerd-bin | egrep -w "U"; then
                echo "update HQPlayerEmbedded...please wait...."
                emerge hqplayerd-bin
            else
                echo "HQPlayerEmbedded is already updated"
            fi
        else
            echo "HQPlayerEmbedded is not installed on this system"
        fi
        ;;
    HQPlayer3)
        if equery --quiet list hqplayer-bin; then
            if emerge -p hqplayer-bin | egrep -w "U"; then
                echo "update HQPlayer3...please wait...."
                emerge hqplayer-bin
            else
                echo "HQPlayer3 is already updated"
            fi
        else
            echo "HQPlayer3 is not installed on this system"
        fi
        ;;
    HQPlayer4)
        if equery --quiet list hqplayer4desktop-bin; then
            if emerge -p hqplayer4desktop-bin | egrep -w "U"; then
                echo "update HQPlayer4...please wait...."
                emerge hqplayer4desktop-bin
            else
                echo "HQPlayer4 is already updated"
            fi
        else
            echo "HQPlayer4 is not installed on this system"
        fi
        ;;
    Networkaudiod)
        if equery --quiet list networkaudiod-bin; then
            if emerge -p networkaudiod-bin | egrep -w "U"; then
                echo "update networkaudiod-bin...please wait...."
                emerge networkaudiod-bin
            else
                echo "networkaudiod-bin is already updated"
            fi
        else
            echo "networkaudiod-bin is not installed on this system"
        fi
        ;;
    Mpd)
        if equery --quiet list media-sound/mpd; then
            if emerge -p media-sound/mpd | egrep -w "U"; then
                echo "update Mpd...please wait...."
                emerge media-sound/mpd
            else
                echo "Mpd is already updated"
            fi
        else
            echo "Mpd is not installed on this system"
        fi
        ;;
    UpMpdCli)
        if equery --quiet list upmpdcli; then
            if emerge -p upmpdcli | egrep -w "U"; then
                echo "update UpMpdCli...please wait...."
                emerge upmpdcli
            else
                echo "UpMpdCli is already updated"
            fi
        else
            echo "UpMpdCli is not installed on this system"
        fi
        ;;
    MyMpd)
        /opt/.gentooplayer/script/mympd_install.sh
        ;;
    All)
        if equery --quiet list squeezelite-R2; then
            if emerge -p squeezelite-R2 | egrep -w "U"; then
                echo "update squeezelite-R2...please wait...."
                emerge squeezelite-R2
            else
                echo "Squeezelite-R2 is already updated"
            fi
        else
            echo "Squeezelite-R2 is not installed on this system"
        fi
        if equery --quiet list squeezelite; then
            if emerge -p squeezelite | egrep -w "U"; then
                echo "update squeezelite...please wait...."
                emerge squeezelite
            else
                echo "Squeezelite-R2 is already updated"
            fi
        else
            echo "Squeezelite-R2 is not installed on this system"
        fi
        if equery --quiet list logitechmediaserver-bin; then
            if emerge -p logitechmediaserver-bin | egrep -w "U"; then
                echo "update LogitechMediaServer...please wait...."
                emerge logitechmediaserver-bin
            else
                echo "LogitechMediaServer is already updated"
            fi
        else
            echo "LogitechMediaServer is not installed on this system"
        fi
        if equery --quiet list hqplayerd-bin; then
            if emerge -p hqplayerd-bin | egrep -w "U"; then
                echo "update HQPlayerEmbedded...please wait...."
                emerge hqplayerd-bin
            else
                echo "HQPlayerEmbedded is already updated"
            fi
        else
            echo "HQPlayerEmbedded is not installed on this system"
        fi
        if equery --quiet list hqplayer-bin; then
            if emerge -p hqplayer-bin | egrep -w "U"; then
                echo "update HQPlayer3...please wait...."
                emerge hqplayer-bin
            else
                echo "HQPlayer3 is already updated"
            fi
        else
            echo "HQPlayer3 is not installed on this system"
        fi
        if equery --quiet list hqplayer4desktop-bin; then
            if emerge -p hqplayer4desktop-bin | egrep -w "U"; then
                echo "update HQPlayer4...please wait...."
                emerge hqplayer4desktop-bin
            else
                echo "HQPlayer4 is already updated"
            fi
        else
            echo "HQPlayer4 is not installed on this system"
        fi
        if equery --quiet list media-sound/mpd; then
            if emerge -p media-sound/mpd | egrep -w "U"; then
                echo "update Mpd...please wait...."
                emerge media-sound/mpd
            else
                echo "Mpd is already updated"
            fi
        else
            echo "Mpd is not installed on this system"
        fi
        if equery --quiet list upmpdcli; then
            if emerge -p upmpdcli | egrep -w "U"; then
                echo "update UpMpdCli...please wait...."
                emerge upmpdcli
            else
                echo "UpMpdCli is already updated"
            fi
        else
            echo "UpMpdCli is not installed on this system"
        fi
        if equery --quiet list networkaudiod-bin; then
            if emerge -p networkaudiod-bin | egrep -w "U"; then
                echo "update networkaudiod-bin...please wait...."
                emerge networkaudiod-bin
            else
                echo "networkaudiod-bin is already updated"
            fi
        else
            echo "networkaudiod-bin is not installed on this system"
        fi
        ;;
esac

case $rsoft in
    squeezelite-R2)
        if equery --quiet list squeezelite-R2; then
            rc-update del squeezelite-R2 default
            emerge -C squeezelite-R2
            emerge --depclean
            echo "squeezelite-R2 has been removed"
        else
            echo "Squeezelite-R2 is not installed on the system"
        fi
        ;;
    squeezelite)
        if equery --quiet list squeezelite; then
            rc-update del squeezelite default
            emerge -C squeezelite
            emerge --depclean
            echo "squeezelite has been removed"
        else
            echo "Squeezelite is not installed on the system"
        fi
        ;;
    logitechMediaServer)
        if equery --quiet list logitechmediaserver-bin; then
            rc-update del logitechmediaserver default
            emerge -C logitechmediaserver-bin
            emerge --depclean
            echo "LogitechMediaServer has been removed"
        else
            echo "LogitechMediaServer is not installed on the system"
        fi
        ;;
    hQPlayerEmbedded)
        if equery --quiet list hqplayerd-bin; then
            rc-update del hqplayerd default
            emerge -C hqplayerd-bin
            emerge --depclean
            echo "HQPlayerEmbedded has been removed"
        else
            echo "HQPlayerEmbedded is not installed on the system"
        fi
        ;;
    hQPlayer3)
        if equery --quiet list hqplayer-bin; then
            emerge -C hqplayer-bin
            emerge --depclean
            echo "HQPlayer3 has been removed"
        else
            echo "HQPlayer3 is not installed on the system"
        fi
        ;;
    hQPlayer4)
        if equery --quiet list hqplayer4desktop-bin; then
            emerge -C hqplayer4desktop-bin
            emerge --depclean
            echo "HQPlayer4 has been removed"
        else
            echo "HQPlayer4 is not installed on the system"
        fi
        ;;
    hQPlayer4)
        if equery --quiet list networkaudiod-bin; then
            rc-update del networkaudiod default
            emerge -C networkaudiod-bin
            emerge --depclean
            echo "networkaudiod has been removed"
        else
            echo "networkaudiod is not installed on the system"
        fi
        ;;
    mpd)
        if equery --quiet list media-sound/mpd; then
            rc-update del mpd default
            emerge -C media-sound/mpd
            emerge --depclean
            echo "Mpd has been removed"
        else
            echo "Mpd is not installed on the system"
        fi
        ;;
    upMpdCli)
        if equery --quiet list upmpdcli; then
            rc-update del upmpdcli default
            emerge -C upmpdcli
            emerge --depclean
            echo "UpMpdCli has been removed"
        else
            echo "UpMpdCli is not installed on the system"
        fi
        ;;
    mympd)
            rc-update del mympd default
            rm -f /usr/bin/mympd
            rm -f /usr/local/bin/mympd
            rm -rf /opt/mympd
            rm -f /usr/lib/systemd/system/mympd.service
            rm -f /lib/systemd/system/mympd.service
            rm -rf /var/lib/mympd
            rm -f /etc/mympd.conf
            rm -f /etc/mympd.conf.dist
            rm -rf /var/lib/mympd
            rm -f /usr/local/etc/mympd.conf
            rm -f /usr/local/etc/mympd.conf.dist
            rm -rf /var/opt/mympd
            rm -rf /etc/opt/mympd
            rm -rf /etc/webapps/mympd
            rc-update del mympd default
            echo "MYmpd has been removed"
        ;;
    mpd_sima)
        if ls /opt/sima; then
            rm -r /opt/sima
            echo "mpd_sima has been removed"
        else
            echo "mpd_sima is already updated"
        fi
        ;;
esac

/etc/init.d/web restart
