#!/bin/sh
sed -i \
         -e 's/#eaebdf/rgb(0%,0%,0%)/g' \
         -e 's/#191919/rgb(100%,100%,100%)/g' \
    -e 's/#ccccad/rgb(50%,0%,0%)/g' \
     -e 's/#bfc674/rgb(0%,50%,0%)/g' \
     -e 's/#eaebdf/rgb(50%,0%,50%)/g' \
     -e 's/#191919/rgb(0%,0%,50%)/g' \
	*.svg
