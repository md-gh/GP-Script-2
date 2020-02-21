#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq dtparam=pwr_led_trigger=none "/boot/config.txt"; then
   echo "disable"
else
   echo "enable"
fi
