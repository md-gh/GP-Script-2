#!/bin/bash


repeats=1

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            usoft="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

/opt/.gentooplayer/script/gp-update0.sh


usoftt=$(echo "$usoft" | sed 's/,/ /g')

emerge $usoftt
