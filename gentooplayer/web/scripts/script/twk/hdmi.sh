#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq hdmi_blanking=1 "/boot/config.txt"; then
   echo "disable"
else
   echo "enable"
fi
