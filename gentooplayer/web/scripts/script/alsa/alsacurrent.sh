#!/bin/bash
aplay --version | grep -Po '[0-9.]+' | awk 'NR==1'
