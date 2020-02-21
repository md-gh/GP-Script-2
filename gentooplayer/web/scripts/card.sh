#!/bin/bash

aplay -l |awk '/^card / { print $0 }'
