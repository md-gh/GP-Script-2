#!/bin/bash

address=$(ip route show | awk '/default/ {print $3}')

#nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep "|" | sed 's/|//g' | sed 's/://g' | awk '!/IPC/'
