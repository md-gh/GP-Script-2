#!/bin/bash

route -n | awk '{print $3}' | grep 255
