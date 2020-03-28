#!/bin/bash
rm -r /newuser/* 2>/dev/null
rm -r /newuser1/* 2>/dev/null
rm -r /newuser2/* 2>/dev/null

sync && echo 3 > /proc/sys/vm/drop_caches