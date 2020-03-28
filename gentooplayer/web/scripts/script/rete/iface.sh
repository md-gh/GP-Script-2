#!/bin/bash

ip -o link show | awk -F': ' '{print $2}'
