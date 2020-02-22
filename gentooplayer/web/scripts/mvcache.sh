#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            move="$2"
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
case $move in
    MoveRoonDatabase)
        mkdir -P /backup/roondatabase
        echo "Copying Database on"
        cp -R /root/.RoonServer/Database /backup/roondatabase/
        rm -rf /root/.RoonServer/Database
        ln -s /backup/roondatabase/Database /root/.RoonServer
        echo "database is now in: /backup/roondatabase"
        file /root/.RoonServer/Database
        sleep 5 ;;
    MoveLmsCache)
        mkdir /backup/LMScache
        echo "Copying Database on"
        cp -R /var/lib/logitechmediaserver/cache /backup/LMScache/
        chown -R logitechmediaserver:logitechmediaserver /backup/LMScache/
        rm -rf /var/lib/logitechmediaserver/cache
        ln -s /backup/LMScache/cache /var/lib/logitechmediaserver/
        chown -R logitechmediaserver:logitechmediaserver /var/lib/logitechmediaserver/
        echo "lms cache is now in: /backup/LMScache"
        sleep 5 ;;
esac
