#!/bin/bash

if dmesg | grep microcode | grep early 1>/dev/null ; then
   echo "Microcode installed"
 else
   echo "Microcode not installed"
fi
