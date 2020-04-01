#!/bin/bash

set -e

repeats=1

clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -c)
            prova="$2"
            shift # past argument
            ;;
        -d)
            prova1="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done

echo "$prova"
echo "$prova1"

ls -l $prova1
