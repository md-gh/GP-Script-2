#!/bin/bash
cat > /etc/security/limits.conf <<EOF
*  hard rtprio  0
*  soft rtprio  0
@realtime hard rtprio  20
@realtime    soft rtprio    10
@audio  - rtprio  99
@audio  - memlock  unlimited
EOF

cat > /etc/sysctl.conf <<EOF
vm.swappiness=10
fs.inotify.max_user_watches = 524288
EOF

cat > /etc/local.d/max_user_freq.start <<EOF
#!/bin/sh
echo 3072 >/sys/class/rtc/rtc0/max_user_freq
echo 3072 >/proc/sys/dev/hpet/max-user-freq
modprobe snd-hrtimer
EOF
chmod +x /etc/local.d/max_user_freq.start
rc-update add local default

cat > /etc/udev/rules.d/40-timer-permissions.rules <<EOF
KERNEL=="rtc0", GROUP="audio"
KERNEL=="hpet", GROUP="audio"
EOF
service udev reload
chgrp audio /dev/hpet /dev/rtc0
chmod 660 /dev/hpet /dev/rtc0

cat > /etc/sysctl.d/60-max-user-freq.conf <<EOF
dev.hpet.max-user-freq=3072
EOF
sysctl -q -p /etc/sysctl.d/60-max-user-freq.conf

reboot
