#!/bin/bash
GP_VERSION="$(sed -n 1p /etc/default/.GP-version).$(sed -n 2p /etc/default/.GP-version)$(sed -n 3p /etc/default/.GP-version)"

echo "$GP_VERSION"
