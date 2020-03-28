#!/bin/bash

mount /boot 2>/dev/null

if grep -q gpu_freq= "/boot/config.txt"; then
   freq=$(grep gpu_freq= "/boot/config.txt" | sed 's/gpu_freq=//g')
   echo "$freq"
else
   echo "default"
fi
