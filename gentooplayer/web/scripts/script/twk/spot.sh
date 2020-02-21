#!/bin/bash

mount /boot 2>/dev/null

if [ -f /etc/local.d/ireteonline.start ]; then
   echo "enable"
else
   echo "disable"
fi
