#!/bin/bash
. /opt/.gentooplayer/function/felenco.sh
gpversion="$(sed -n 1p /etc/default/.GP-version).$(sed -n 2p /etc/default/.GP-version)$(sed -n 3p /etc/default/.GP-version)"
gpmodel=$(sed -n 16p /opt/.gentooplayer/GentooPlayer/gentooplayer/.hw_model)

echo -e "$Red GentooPlayer $Color_Off $BBlue $gpmodel $Color_Off $BBlack version=$gpversion $Color_Off"
