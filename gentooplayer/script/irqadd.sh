#!/bin/bash
if
cat > /etc/local.d/iqraffinity.start <<EOF
#!/bin/bash
sleep 8
/etc/default/irq-affinity-start.sh
EOF
chmod +x /etc/local.d/iqraffinity.start; then
    echo -e "\n \e[38;5;154m[OK]\e[0m\n"
else
    echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
fi
