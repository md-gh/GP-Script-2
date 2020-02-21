#!/bin/bash
if
cat > /etc/local.d/cpugovernor.start <<EOF
#!/bin/bash
sleep 10
/opt/.gentooplayer/GentooPlayer/gentooplayer/func/dietpi-set_cpu
EOF
chmod +x /etc/local.d/cpugovernor.start; then
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
else
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
fi
