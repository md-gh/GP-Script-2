#!/bin/bash
. /opt/.gentooplayer/function/felenco.sh
gpversion="$(sed -n 1p /etc/default/.GP-version).$(sed -n 2p /etc/default/.GP-version)$(sed -n 3p /etc/default/.GP-version)"
gpmodel=$(sed -n 16p /opt/.gentooplayer/GentooPlayer/gentooplayer/.hw_model)

gp-update

clear
echo -e "$BRed GentooPlayer $Color_Off $BBlue $gpmodel $Color_Off $BBlack version=$gpversion $Color_Off"
echo
echo -e "$BBlack Latest News:$Color_Off"
echo
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e "$BBlack 25.02.19 A new version of MyMpd is available v.6.2.0$Color_Off"
echo
echo -e "Changelog: https://github.com/jcorporation/myMPD/releases/tag/v6.2.0"
echo
echo -e "to update:
 ssh: command $BBlack mympd-up$Color_Off $BGreen(faster)$Color_Off
 or
 web-interface > System H. Software Upd/Rem > Select Software Update > MyMpd > EXCUTE $BRed(slow)$Color_Off
 or
 web-interface > System A. Excute Command > mympd-up > EXCUTE $BGreen(faster)$Color_Off"
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
