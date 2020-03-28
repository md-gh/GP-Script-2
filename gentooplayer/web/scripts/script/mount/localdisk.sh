#!/bin/bash

#lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT > /tmp/disk
#"values": { "script": "/etc/default/web/mount/localdisk.sh" },

#cat /tmp/disk

#lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | sed 's/\├─//g' | sed 's/\└─//g'
#lsblk -o NAME,SIZE,FSTYPE| sed 's/\├─//g' | sed 's/\└─//g'
lsblk -o KNAME | awk 'length($1) > 3 { print $1 }' | sed 's\KNAME\\g'
