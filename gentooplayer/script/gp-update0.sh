#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh

echo ""
echo ""
echo -e "Local overlay and gentooplayer scripts will be updated"

sleep 2

cd /tmp
rm -r GP-overlay* 2>/dev/null
rm -r script* 2>/dev/null
rm -r GP-script* 2>/dev/null

if
mount -l | grep "none on /etc type tmpfs" 1>/dev/null && echo -e "\e[38;5;82mRamSystem you can not use gp-update\e[0m"; then
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    exit 0
else
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
fi

if
git clone https://github.com/antonellocaroli/GP-overlay.git; then
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
else
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    exit 0
fi

if
rm -rf /var/db/repos/antonellocaroli; then
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
else
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
fi

if
mv GP-overlay/ /var/db/repos/antonellocaroli; then
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
else
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
fi
