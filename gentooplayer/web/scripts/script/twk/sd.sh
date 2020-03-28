#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq dtoverlay=sdhost,overclock_50=100 "/boot/config.txt"; then
   echo "enable"
else
   echo "disable"
fi
