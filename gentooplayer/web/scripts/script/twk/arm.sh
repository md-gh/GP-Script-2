#!/bin/bash

mount /boot 2>/dev/null

if grep -q arm_freq= "/boot/config.txt"; then
   freq=$(grep arm_freq= "/boot/config.txt" | sed 's/arm_freq=//g')
   echo "$freq"
else
   echo "default"
fi
