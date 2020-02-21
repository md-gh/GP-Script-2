#!/bin/bash
if
cat > /etc/local.d/processtool.start <<EOF
#!/bin/bash
sleep 10
/opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1
EOF
chmod +x /etc/local.d/processtool.start; then
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
else
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
fi

