#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -c)
            alsav="$2"
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
. /opt/.gentooplayer/function/fcolors.sh
case $alsav in
    1.0.29)
        emerge --ask -k =media-libs/alsa-lib-1.0.29 =media-sound/alsa-utils-1.0.29
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.initd-r6 /etc/init.d/alsasound
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.confd-r4 /etc/conf.d/alsasound
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
    1.1.2)
        emerge --ask -k =media-libs/alsa-lib-1.1.2 =media-sound/alsa-utils-1.1.2
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
    1.1.6)
        emerge --ask -k =media-libs/alsa-lib-1.1.6 =media-sound/alsa-utils-1.1.6
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
    1.1.8)
        emerge --ask -k =media-libs/alsa-lib-1.1.8 =media-sound/alsa-utils-1.1.8
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.initd-r7 /etc/init.d/alsasound
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.confd-r4 /etc/conf.d/alsasound
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
    1.1.9)
        emerge --ask -k =media-libs/alsa-lib-1.1.9 =media-sound/alsa-utils-1.1.9
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
    1.2.1.2)
        emerge --ask -k =media-libs/alsa-lib-1.2.1.2 =media-sound/alsa-utils-1.2.1
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.initd-r8 /etc/init.d/alsasound
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.confd-r4 /etc/conf.d/alsasound
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
    1.2.2)
        emerge --ask -k =media-libs/alsa-lib-1.2.2 =media-sound/alsa-utils-1.2.2
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.initd-r8 /etc/init.d/alsasound
        cp /var/db/repos/antonellocaroli/media-sound/alsa-utils/files/alsasound.confd-r4 /etc/conf.d/alsasound
        /etc/init.d/alsasound restart
        echo
        echo
        echo -e ""$BBlue"alsa switching v.$alsav ok$color_off" ;;
esac
