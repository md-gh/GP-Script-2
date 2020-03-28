#!/bin/bash

echo -e "https://wiki.gentoo.org/wiki/Xfce"
echo -e "https://wiki.gentoo.org/wiki/Xorg/Guide"
echo -e "https://wiki.gentoo.org/wiki/NVidia/nvidia-drivers/it"

echo -e "si vuole continuare con l´esecuzione dello script y/n"
read continuare
if [ "$continuare" = "n" ]; then
    exit 0
fi

function select_videocard() {
    # selezione del tipo di scheda video
    videocard=""
    clear
    while [ "$videocard" == "" ] ; do
        cat <<-ECHOICE

	videocard

	0) nVidia (driver nouveau)
	1) AMD/ATI
	2) intel
	3) nVidia (driver nVidia)- Assicurarsi di aver installato un kernel non RT

ECHOICE


        read -N1 -p 'Enter the corresponding number (0|1|2|3): ' Scelta_videocard
        echo
        case "$Scelta_videocard" in
            0)
                videocard="nVidia_driver_nouveau"
                ;;
            1)
                videocard="AMD/ATI"
                ;;
            2)
                videocard="intel"
                ;;
            3)
                videocard="nVidia_driver_nVidia"
                ;;
            *)
                clear

                echo -e "\a\nError: Unspecified selection.\nPlease enter a number between 0 and 1.\n"
        esac
        if [ "$videocard" != "" ]; then
            echo -e "\nChoice made: videocard $videocard\n"
            read -s -N1 -p 'Confirm and proceed with the installation? (y/N)'
            clear
            echo
            [ "$REPLY" != "y" ] && videocard=""
        fi
    done
}

select_videocard
case "$videocard" in
    nVidia_driver_nouveau)
        card="nouveau"
        ;;
    AMD/ATI)
        card="radeon"
        ;;
    intel)
        card="intel"
        ;;
    nVidia_driver_nVidia)
        card="nvidia"
        ;;
esac

echo VIDEO_CARDS='"'$card'"' >> /etc/portage/make.conf
clear


read -p "digitare il vostro nome utente:"  username


emerge xorg-server xfce4-meta xfce4-terminal x11-misc/slim slim-themes

cat > /etc/conf.d/xdm <<EOF
# We always try and start X on a static VT. The various DMs normally default
# to using VT7. If you wish to use the xdm init script, then you should ensure
# that the VT checked is the same VT your DM wants to use. We do this check to
# ensure that you haven't accidentally configured something to run on the VT
# in your /etc/inittab file so that you don't get a dead keyboard.
CHECKVT=7
# What display manager do you use ?  [ xdm | gdm | kdm | gpe | entrance ]
# NOTE: If this is set in /etc/rc.conf, that setting will override this one.
DISPLAYMANAGER="slim"
EOF

echo "exec startxfce4" > /home/$username/.xinitrc
chown $username /home/$username/.xinitrc
chgrp $username /home/$username/.xinitrc
rc-update add xdm default
rc-update add dbus default

cat > /etc/slim.conf <<EOF
# Path, X server and arguments (if needed)
# Note: -xauth $authfile is automatically appended
default_path        /bin:/usr/bin:/usr/local/bin
default_xserver     /usr/bin/X
xserver_arguments   -nolisten tcp -br -deferglyphs 16 vt07

# Commands for halt, login, etc.
halt_cmd            /sbin/shutdown -h now
reboot_cmd          /sbin/shutdown -r now
console_cmd         /usr/bin/xterm -C -fg white -bg black +sb -T "Console login" -e /bin/sh -c "/bin/cat /etc/issue; exec /bin/login"
#suspend_cmd        /usr/sbin/suspend

# Full path to the xauth binary
xauth_path         /usr/bin/xauth

# Xauth file for server
authfile           /var/run/slim.auth


# Activate numlock when slim starts. Valid values: on|off
numlock             on

# Hide the mouse cursor (note: does not work with some WMs).
# Valid values: true|false
# hidecursor          false

# This command is executed after a succesful login.
# you can place the %session and %theme variables
# to handle launching of specific commands in .xinitrc
# depending of chosen session and slim theme
#
# NOTE: if your system does not have bash you need
# to adjust the command according to your preferred shell,
# i.e. for freebsd use:
# login_cmd           exec /bin/sh - ~/.xinitrc %session
login_cmd           exec /bin/bash -login ~/.xinitrc %session
#login_cmd           exec /bin/bash -login /usr/share/slim/Xsession %session

# Commands executed when starting and exiting a session.
# They can be used for registering a X11 session with
# sessreg. You can use the %user variable
#
# sessionstart_cmd	some command
# sessionstop_cmd	some command
sessionstart_cmd	/usr/bin/sessreg -a -l :0.0 %user
sessionstop_cmd     /usr/bin/sessreg -d -l :0.0 %user

# Start in daemon mode. Valid values: yes | no
# Note that this can be overriden by the command line
# options "-d" and "-nodaemon"
daemon	yes

# Available sessions:
# The current chosen session name replaces %session in the login_cmd
# above, so your login command can handle different sessions.
# If no session is chosen (via F1), %session will be an empty string.
# see the xinitrc.sample file shipped with slim sources
#sessions            xfce4,icewm-session,wmaker,blackbox
# Alternatively, read available sessions from a directory of scripts:
#sessiondir           /etc/X11/Sessions
# Or, read available sessions from the xsessions desktop files --
# note that this may provide a full path to the session executable!
sessiondir	/usr/share/xsessions

# Executed when pressing F11 (requires media-gfx/imagemagick for import)
# Alternative is media-gfx/scrot. See Gentoo bug 252241 for more info.
screenshot_cmd      import -window root /slim.png
#screenshot_cmd      scrot /root/slim.png

# welcome message. Available variables: %host, %domain
welcome_msg         Welcome to %host

# Session message. Prepended to the session name when pressing F1
# session_msg         Session:

# shutdown / reboot messages
shutdown_msg       The system is halting...
reboot_msg         The system is rebooting...

# default user, leave blank or remove this line
# for avoid pre-loading the username.
#default_user        simone

# Focus the password field on start when default_user is set
# Set to "yes" to enable this feature
#focus_password      no

# Automatically login the default user (without entering
# the password. Set to "yes" to enable this feature
#auto_login          no


# current theme, use comma separated list to specify a set to
# randomly choose from
current_theme       default

# Lock file, /etc/init.d/xdm expects slim.pid
lockfile            /run/slim.pid

# Log file
logfile             /var/log/slim.log
EOF
USE="X" emerge dbus
rc-update add dbus default

echo -e "installato i driver nVidia proprietari? y/n"
read installato
if [ "$installato" = "y" ]; then
    echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
fi
exit 0