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


usoftt=$(echo "$usoft" | sed 's/,/ /g')

emerge -C $usoftt && emerge --depclean
