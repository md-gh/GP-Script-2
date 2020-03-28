#!/bin/bash

mount /boot 2>/dev/null

if grep -q sdram_freq= "/boot/config.txt"; then
   freq=$(grep sdram_freq= "/boot/config.txt" | sed 's/sdram_freq=//g')
   echo "$freq"
else
   echo "default"
fi
