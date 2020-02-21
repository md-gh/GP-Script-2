#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq dtparam=act_led_trigger=none "/boot/config.txt"; then
   echo "disable"
else
   echo "enable"
fi
