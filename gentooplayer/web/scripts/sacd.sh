#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            imput="$2"
            shift # past argument
            ;;
        -b)
            out="$2"
            shift # past argument
            ;;
        -c)
            chan="$2"
            shift # past argument
            ;;
        -d)
            outtipe="$2"
            shift # past argument
            ;;
        -e)
            extra="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

sacd_extract $chan $outtipe $extra -i"$imput" -o $out
