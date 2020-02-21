#!/bin/bash

address=$(ip route show | awk '/default/ {print $3}')

#nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
nmap -sS --script nfs-showmount.nse -p T:111 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/|//g; s/_//g'
