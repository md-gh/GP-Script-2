#!/bin/bash

#set -e

#repeats=1
#text="I'm called"
#filename='/etc/conf.d/mpdbp-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            ifname="$2"
            shift # past argument
            ;;
        -b)
            iprou="$2"
            shift # past argument
            ;;
        -c)
            netmas="$2"
            shift # past argument
            ;;
        -d)
            ippc="$2"
            shift # past argument
            ;;
        -e)
            dhc="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

cat > /etc/conf.d/net <<EOF
config_$ifname=( "$ippc netmask $netmas" )
routes_$ifname=( "default gw $iprou" )
dns_servers_$ifname=( "$iprou" )
EOF
ln -s /etc/init.d/net.lo /etc/init.d/net.$ifname
rc-update add net.$ifname default
/etc/init.d/net.$ifname restart

if [ "$dhc" = "yes" ]; then
    rc-update del dhcpcd default
fi
