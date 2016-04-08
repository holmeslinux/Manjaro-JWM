#!/bin/bash
#
# Simple bash script to install printer support
#
# Written by Carl Duff (adapted holmeslinux)

# Information about this script for the user
echo "${title}Install printer support${nrml}.

This will install the necessary software to run printer.

Press ${grnb}[Enter]${nrml} to proceed. You may still cancel the process when prompted."

read
pacman -S manjaro-printer simple-scan cups-openrc && rc-update add cupsd default && rc-service cupsd start
read -p $'\n'"Process Complete. Press ${grnb}[Enter]${nrml} to continue."$'\n'
exit 0