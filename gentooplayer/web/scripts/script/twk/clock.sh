#!/bin/bash
cat /etc/local.d/max_user_freq.start | grep /sys/class/rtc/rtc0/max_user_freq | awk '{print $2}'
