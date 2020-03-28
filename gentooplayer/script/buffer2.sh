#!/bin/bash

function pausa1() {
    echo
    read -s -p 'Done, press "Enter" to return to the menu...'
    clear
    select_twk
    echo
}

cat > /etc/sysctl.conf <<EOF
net.core.rmem_max=8388608
net.core.wmem_max=8388608
net.core.rmem_default=65536
net.core.wmem_default=65536
net.ipv4.tcp_rmem='4096 87380 8388608'
net.ipv4.tcp_wmem='4096 65536 8388608'
net.ipv4.tcp_mem='8388608 8388608 8388608'
net.ipv4.route.flush=1
EOF
