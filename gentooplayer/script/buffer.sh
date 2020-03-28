#!/bin/bash

function select_buffer() {
    buffer=""
    clear
    while [ "$buffer" == "" ] ; do
        cat <<-ECHOICE

	Choose settings:

	0) setting1
	1) setting2
	2) setting3
	3) setting4
	4) original setting

ECHOICE


        read -N1 -p 'digitare il numero corrispondente (0|1|2|3|4): ' sceltabuffer
        echo
        case "$sceltabuffer" in
            0)
                buffer="impostazioni1"
                ;;
            1)
                buffer="impostazioni2"
                ;;
            2)
                buffer="impostazioni3"
                ;;
            3)
                buffer="impostazioni4"
                ;;
            4)
                buffer="impostazioni_originali"
                ;;
            *)
                clear
                echo -e "\a\nError: Unspecified selection.\nPlease enter a number between 0 and 1.\n"
        esac
        if [ "$buffer" != "" ]; then
            echo -e "\nscelta: \e[38;5;88m$buffer\e[0m\n"
            read -s -N1 -p 'Confermi la scelta? (y/N)'
            clear
            echo
            [ "$REPLY" != "y" ] && buffer=""
        fi
    done
}

select_buffer

case "$buffer" in
    impostazioni1)
        buffernum="buffer1"
        ;;
    impostazioni2)
        buffernum="buffer2"
        ;;
    impostazioni3)
        buffernum="buffer3"
        ;;
    impostazioni3)
        buffernum="buffer4"
        ;;
    impostazioni_originali)
        buffernum="buffer5"
        ;;
esac

clear

/opt/.gentooplayer/script/$buffernum.sh
