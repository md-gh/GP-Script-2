#!/bin/bash
aplay --version | grep -Po '[0-9.]+' /tmp/aplayv | awk 'NR==1'
