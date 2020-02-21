#!/bin/bash

mount /boot 2>/dev/null

if grep -q core_freq= "/boot/config.txt"; then
   freq=$(grep core_freq= "/boot/config.txt" | sed 's/core_freq=//g')
   echo "$freq"
else
   echo "default"
fi
