#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq dtoverlay=pi3-disable-wifi "/boot/config.txt"; then
   echo "disable"
else
   echo "enable"
fi
