#!/bin/bash

address=$(ip route show | awk '/default/ {print $3}')

nmap -sP "$address"/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
