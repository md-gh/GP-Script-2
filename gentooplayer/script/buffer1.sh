#!/bin/bash

function pausa1() {
    echo
    read -s -p 'Done, press "Enter" to return to the menu...'
    clear
    select_twk
    echo
}

cat > /etc/sysctl.conf <<EOF
net.core.rmem_max=26214400
net.core.wmem_max=26214400
net.ipv4.tcp_rmem='4096 1048576 26214400'
net.ipv4.tcp_wmem='4096 1048576 26214400'
net.ipv4.tcp_mem='26214400 26214400 26214400'
EOF

#echo -e "restart the rpi? y/n"
#read riavviare
#	if [ "$riavviare" = "y" ]; then
#        reboot
#    fi
#
#exit 0

#pausa1

#twk
