#!/bin/bash

mount /boot 2>/dev/null

if grep -Fxq dtparam=eth_led0=14 "/boot/config.txt"; then
   echo "disable"
else
   echo "enable"
fi
