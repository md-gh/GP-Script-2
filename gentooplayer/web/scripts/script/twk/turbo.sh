#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq force_turbo=1 "/boot/config.txt"; then
   echo "enable"
else
   echo "disable"
fi
