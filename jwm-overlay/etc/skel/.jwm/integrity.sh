#!/bin/bash
#
# Simple bash script to verify the integrity of files in JWM
#
# Written by Carl Duff (adapted holmeslinux)

# Information about this script for the user
echo "${title}Verify the integrity of files in JWM${nrml}.

The following will be checked the integrity of files JWM (Joe's Window Manager).

Press ${grnb}<enter>${nrml} to verify the integrity. You may still cancel the process when prompted."

read
jwm -p
read -p $'\n'"Verification Complete. See above the problems encountered with integrity checking. Any doubt seek our forum (forum.manjaro.org). Press ${grnb}<enter>${nrml} to finish."$'\n'
exit 0