#!/bin/bash

#lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT > /tmp/disk
#"values": { "script": "/etc/default/web/mount/localdisk.sh" },

#cat /tmp/disk

#lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | sed 's/\├─//g' | sed 's/\└─//g'
#lsblk -o NAME,SIZE,FSTYPE| sed 's/\├─//g' | sed 's/\└─//g'
#ls -1v /media | cat -n
ls -1v /media
