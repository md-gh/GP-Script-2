#!/bin/bash

if [ -f /etc/default/.dietpi-process_tool ]; then
    nano /etc/default/.dietpi-process_tool
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1
    echo -e "\n \e[38;5;154m─────────────────────────────────────────────────────\e[0m\n \e[1mGentooPlayer Process-Tool\n\e[30m Use \e[1;38;5;88mprocess-tool-add \e[30mto add changes to the restart\n it is sufficient to do it only once - even if you change settings\e[0m\n \e[38;5;154m─────────────────────────────────────────────────────\e[0m"
else
    /opt/.gentooplayer/script/process_tool_set.sh
    nano /etc/default/.dietpi-process_tool
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1
    echo -e "\n \e[38;5;154m─────────────────────────────────────────────────────\e[0m\n \e[1mGentooPlayer Process-Tool\n\e[30m Use \e[1;38;5;88mprocess-tool-add \e[30mto add changes to the restart\n it is sufficient to do it only once - even if you change settings\e[0m\n \e[38;5;154m─────────────────────────────────────────────────────\e[0m"
fi
