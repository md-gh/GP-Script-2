#!/bin/bash


if
rc-update show -v | egrep -w "squeezelite " | grep default 1>/dev/null; then
    echo -e "enable"
else
    echo -e "disable"
fi
