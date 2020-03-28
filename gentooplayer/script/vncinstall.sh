#!/bin/bash
#aggiungere a  package.use net-misc/tigervnc server


emerge --ask net-misc/tigervnc
read -p "digitare il vostro nome utente:"  username
echo DISPLAYS=\"$username:1\" >> /etc/conf.d/tigervnc
mkdir /home/$username/.vnc
chmod -R 777 /home/$username/.vnc/

cat > /home/$username/.vnc/xstartup <<EOF
#!/bin/sh
startxfce4 &
EOF

chmod +x /home/$username/.vnc/xstartup
echo -e "aggiungere tighervnc all´avvio? y/n"
read aggiungere
if [ "$aggiungere" = "y" ]; then
    rc-update add tigervnc default
fi

echo -e "################################################################################"
echo -e "###################IMPORTANTE###################################################"
echo -e "da utente normale bisogna impostare la password per vnc con il comando vncpasswd"
echo -e "################################################################################"
echo -e "################################################################################"