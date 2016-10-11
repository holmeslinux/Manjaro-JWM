#!/bin/sh
sed -i \
         -e 's/#d9cdb3/rgb(0%,0%,0%)/g' \
         -e 's/#141e3b/rgb(100%,100%,100%)/g' \
    -e 's/#d9cdb3/rgb(50%,0%,0%)/g' \
     -e 's/#c59a7a/rgb(0%,50%,0%)/g' \
     -e 's/#e5decf/rgb(50%,0%,50%)/g' \
     -e 's/#141e3b/rgb(0%,0%,50%)/g' \
	*.svg
