#!/bin/bash

function pausa1() {
    echo
    read -s -p 'Done, press "Enter" to return to the menu...'
    clear
    select_twk
    echo
}

cat > /etc/sysctl.conf <<EOF
# Controls IP packet forwarding
net.ipv4.ip_forward = 0

# Controls source route verification
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1

# Disables IP source routing
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_source_route = 0

# Controls the System Request debugging functionality of the kernel
kernel.sysrq = 0

# Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
kernel.core_uses_pid = 1

# Increase maximum amount of memory allocated to shm
# Only uncomment if needed!
# kernel.shmmax = 67108864
# Disable ICMP Redirect Acceptance
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_redirects = 0

# Enable Log Spoofed Packets, Source Routed Packets, Redirect Packets
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.all.log_martians = 1

# Decrease the time default value for tcp_fin_timeout connection
net.ipv4.tcp_fin_timeout = 25

# Decrease the time default value for tcp_keepalive_time connection
net.ipv4.tcp_keepalive_time = 1200

# Turn on the tcp_window_scaling
net.ipv4.tcp_window_scaling = 1

# Turn on the tcp_sack
net.ipv4.tcp_sack = 1

# tcp_fack should be on because of sack
net.ipv4.tcp_fack = 1

# Turn on the tcp_timestamps
net.ipv4.tcp_timestamps = 1

# Enable TCP SYN Cookie Protection
net.ipv4.tcp_syncookies = 1

# Enable ignoring broadcasts request
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Enable bad error message Protection
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Make more local ports available
# net.ipv4.ip_local_port_range = 1024 65000
# Set TCP Re-Ordering value in kernel to '5'

net.ipv4.tcp_reordering = 5

# Lower syn retry rates
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 3

# Set Max SYN Backlog to '2048'
net.ipv4.tcp_max_syn_backlog = 2048

# Various Settings
net.core.netdev_max_backlog = 1024

# Increase the maximum number of skb-heads to be cached
net.core.hot_list_length = 256

# Increase the tcp-time-wait buckets pool size
net.ipv4.tcp_max_tw_buckets = 360000

# This will increase the amount of memory available for socket input/output queues
net.core.rmem_default = 65535
net.core.rmem_max = 8388608
net.ipv4.tcp_rmem = 4096 87380 8388608
net.core.wmem_default = 65535
net.core.wmem_max = 8388608
net.ipv4.tcp_wmem = 4096 65535 8388608
net.ipv4.tcp_mem = 8388608 8388608 8388608
net.core.optmem_max = 40960
EOF

