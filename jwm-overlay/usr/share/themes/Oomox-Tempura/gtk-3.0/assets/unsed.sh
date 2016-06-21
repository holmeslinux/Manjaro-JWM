#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#eaebdf/g' \
         -e 's/rgb(100%,100%,100%)/#191919/g' \
    -e 's/rgb(50%,0%,0%)/#ccccad/g' \
     -e 's/rgb(0%,50%,0%)/#bfc674/g' \
 -e 's/rgb(0%,50.196078%,0%)/#bfc674/g' \
     -e 's/rgb(50%,0%,50%)/#eaebdf/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#eaebdf/g' \
     -e 's/rgb(0%,0%,50%)/#191919/g' \
	*.svg
