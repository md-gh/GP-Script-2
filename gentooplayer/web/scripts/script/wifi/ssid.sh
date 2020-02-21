#!/bin/bash

#iw wlan0 scan | grep SSID: | awk '{print $2,$3,$4,$5}' > /tmp/ssid
iw wlan0 scan | grep SSID: | awk '{ print substr($0, index($0,$2)) }' > /tmp/ssid
cat /tmp/ssid
