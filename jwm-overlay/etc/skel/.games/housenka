#!/bin/bash
##############################################################################
#                                                                            #
#   Author : Martin "BruXy" Bruchanov, bruxy at regnet.cz                    #
#   URL    : http://bruxy.regnet.cz                                          #
#   Version: 1.01 (Wed Jan  9 20:04:26 CET 2013)                             #
#                                                                            #
##############################################################################
MW=$(tput cols)
MH=$(tput lines)
MH=$[MH-1] # bottom line is used for info and score
CONFIG=~/.housenka
DEFAULT_FOOD_NUMBER=2 # reset after game over in func. new_level
FOOD_NUMBER=0
DEATH=0
SCORE=0
TIMING=0.1            # delay constant, lower value => faster moves
C=2                   # game cycle
declare -A FOOD
_STTY=$(stty -g)      # Save current terminal setup
printf "\e[?25l"      # Turn of cursor 
printf "\e]0;HOUSENKA\007"
stty -echo -icanon
USER=$(whoami)
NAME=$(grep $USER /etc/passwd | cut -d : -f 5)

#############
# ANSI data #
#############

GAME_OVER[0]="\e[1;35m╥┌  ╓─╖ ╥ ╥ ╥─┐ ╥─┐    ╥ ╥ ╥┐  ╥ ┬\e[0m"
GAME_OVER[1]="\e[0;31m╟┴┐ ║ ║ ║\║ ╟┤  ║      ╟─╢ ╟┴┐ ╨╥┘\e[0m"
GAME_OVER[2]="\e[1;31m╨ ┴ ╙─╜ ╨ ╨ ╨─┘ ╨─┘    ╨ ╨ ╨ ┴  ╨ \e[0m"
GAME_OVER[3]="\e[0;32m╥────────────────────────────────╥\e[0m"
GAME_OVER[4]="\e[1;32m║  Stiskni ENTER pro novou hru!  ║\e[0m"
GAME_OVER[5]="\e[1;36m╨────────────────────────────────╨\e[0m"

#############
# FUNCTIONS #
#############

function at_exit() {
	printf "\e[?9l"          # Turn off mouse reading
	printf "\e[?12l\e[?25h"  # Turn on cursor
	stty "$_STTY"            # reinitialize terminal settings
	tput sgr0
	clear
}

function get_first() {
# Return: first index of array
    eval echo \${!$1[@]} | cut -d ' ' -f 1
}

function gen_food() {
	local x y food
	for ((i=0; i<$[2*$FOOD_NUMBER]; i++))
	do
		x=$[RANDOM % (MW-2) + 2]
		y=$[RANDOM % (MH-2) + 2]
		# check if leaf position is unique
		if [ $(echo ${!FOOD[@]} | tr ' ' '\n' | grep -c "^$y;$x$") -gt 0 ] 
		then
			: $[i--]
			continue
		fi
		food=$[i & 1] # 0 -- poison, 1 -- leaf
		FOOD["$y;$x"]=$food
		if [ $food -eq 1 ] ; then 
			printf "\e[$y;${x}f\e[1;32m♠\e[0m";
		else 
			printf "\e[$y;${x}f\e[1;31m♣\e[0m"; 
		fi
	done
}

function check_food() {

	local first
	# check what was eaten in garden
	if [ "${FOOD["$HY;$HX"]}" == "1" ] ; then
		unset FOOD["$HY;$HX"]
		: $[FOOD_NUMBER--] $[SCORE++]
		((FOOD_NUMBER==0)) && return 
	elif [ "${FOOD["$HY;$HX"]}" == "0" ] ; then 
		DEATH=1
	else
		first=$(get_first HOUSENKA)
		printf "\e[${HOUSENKA[$first]}f "
		unset HOUSENKA[$first]			
	fi
	# do not break into wall
	if [ $HY -le 1 ] || [ $HY -ge $MH ] || [ $HX -le 1 ] || [ $HX -ge $MW ] 
	then
		DEATH=2
	fi
	# check if Housenka does not bite herself
	if [ ! -z "$KEY" -a $C -gt 4 ] ; then
		local last
		last=${#HOUSENKA[@]}
		if [ $(echo ${HOUSENKA[@]} | tr ' ' '\n' | \
			   head -n $[last-2] | grep -c "^$HY;$HX$") -gt 0 ] ; then
			DEATH=3
		fi
	fi
}

function game_over() {
	trap : ALRM # disable interupt
	printf "\a"
	centered_window 34 ${#GAME_OVER[@]} GAME_OVER 
	if [ $SCORE -gt $TOP_SCORE ] ; then
		echo $SCORE > $CONFIG
		TOP_SCORE=$SCORE
	fi
	read
	DEATH=0 SCORE=0 DEFAULT_FOOD_NUMBER=2
	new_level
}

function centered_window() {
# $1 width $2 height $3 content
	w=$1 h=$2
	x=$[(MW-w)/2]
	y=$[(MH-h)/2]
	ul=$y";"$x
	bl=$[y+h+1]";"$x
	printf "\e[${ul}f┌"; printf '─%.0s' $(eval echo {1..$w}); printf '┐\n'
	for i in $(eval echo {0..$h}); 
	do 
		printf "\e[$[y+i+1];${x}f│";
		echo -en "$(eval printf \"%s\" \"\${$3[\$i]}\")"
		printf "\e[$[y+i+1];$[x+w+1]f│";
	done
	printf "\e[${bl}f└"; printf '─%.0s' $(eval echo {1..$w}); printf '┘\n'
}

function move() {
	check_food
	if [ $DEATH -gt 0 ] ; then game_over; fi
	if [ $FOOD_NUMBER -eq 0 ] ; then new_level;	fi

	echo -en "\e[$HY;${HX}f\e[1;33;42m☻\e[0m"

	( sleep $TIMING; kill -ALRM $$ ) &

	case "$KEY" in
		A) HY=$[HY-1] ;; # Up
		B) HY=$[HY+1] ;; # Down
		C) HX=$[HX+1] ;; # Right	
		D) HX=$[HX-1] ;; # Left
	esac

	HOUSENKA[$C]="$HY;$HX"
	: $[C++]	
	game_info
}

function draw_area() {
# draw play area
printf "\e[31m"
local x y o="█"
for ((x=0;x<=$MW;x++))
do
	printf  "\e[1;${x}f$o\e[$MH;${x}f$o"
	sleep 0.005
done
for ((y=0;y<=$MH;y++))
do
	printf "\e[${y};1f$o\e[${y};${MW}f$o"
	sleep 0.01
done
}

function new_level() {
	unset HOUSENKA
	for i in ${!FOOD[@]}; do unset FOOD[$i]; done # erase leaves and poison
	clear
	draw_area
	FOOD_NUMBER=$[DEFAULT_FOOD_NUMBER*=2]
	gen_food
	HX=$[MW/2] HY=$[MH/2]  # start position in the middle of the screen
	# body initialization
	HOUSENKA=([0]="$[HY-2];$HX" [1]="$[HY-1];$HX" [2]="$HY;$HX") 
	KEY='' 
	C=2
	trap move ALRM
}

function title_screen() {
TITLE="QlpoOTFBWSZTWWMw1D8AAnd//X38AIhAA/24Cg2UCD7H13BVRH9ktkYEBAgAEABQ
BHgAEQBSlBJEQhqaA0ZDQBoA0ABpoBo9Rk0Ghw00wQyGmmRkwgGmgDCaNMmABA0E
KRJCTTIDIAAAAAyBkNDQNNHqHDTTBDIaaZGTCAaaAMJo0yYAEDQ4aaYIZDTTIyYQ
DTQBhNGmTAAgadZFPhSv08GL4IDbz4ctYPMQnUncHF0csCYaeprXNsFiBI3jqAqr
eZINIEZYBM0vKFjDLrT3O9d7u0YdyNmszDTqrCoaow3YRJGmq1mpO9ZAbqoXLRBc
sNPFvNGSbnbbDlhVhwUxhQ2lyXlxhssjLVysN8tVGpyiODkVooK4kzcZBVBBouKq
K4k3RKUuppicgMDWCYG23aU3vWmMOHN8HBjaSTYb43vjg4bTqDizjjW5iojfdt7O
DhnoedhCmSaWgoUq6IyuzGTVFAUs66ujrbwJmIp54zi8U0Jvl2dG7jlOcZy0IU8Q
HY32Ojyejm45lswDjSi5KwUwUUlAIQ01SRKUtKU1Hjwg4A7BIMFZ3MMYMQHc2nHg
Fi88aPlyBeYkZTTyRgUml+nl5p3CxSMeGHDUCBTstZpOZckIU8f7lIckxlKZ53hT
YzK0p+YzytGd2hNg2ZCrUpkv09fqowZ9vLuiQCDnIRUPoBDAIVRIZkQO0AKOpQ0o
msRVHATFQU7vc7/1AfWSlJFEkFIrRKQUlVRCSlVNUlLQDMCxBAlAlIkEQTMFMkTM
KkKVBJARFVEBD9hI9tR52USwDECnHMMIoyMqxgMsg0BodaBnMaMbCUaR1ZLkoYFR
EgUFAFNBEoxRgYJqQNQg9r4/g7vn+99/Gsj4bVxAAJfFf177dEjRn5b+cAhI82SQ
jRPNoFhdnAMJcvMkDUJEOiRqlRWaGSUhKgJZGIkiEkGS/jv9e9m2vitRmRjm0T38
FrpAS4kkIYQliBkCQnEYYP80AEjqXFAyVSw1tRWIFcZFUcAwaeljJUjJfQ8Ph9X1
Q+3t/mIXWLjCLuLwg1WEYiUo038wzoqSHpSaSOKUde7LhfHRdQzqlxs3rJKmOROc
o6Y6ZDm+THkzMzIdPXzUOo4RVH/xdyRThQkGMw1D8A=="
	SCR=`echo "$TITLE" | base64 -d | bzcat` #unpack main screen
	local i j IFS=$'\n' 
	clear
	# center on screen
	for ((j=0;j<$[(MH-25)/2];j++)) do echo; done
	for i in $SCR
	do	
		for ((j=0;j<$[(MW-63)/2];j++)) do echo -n " "; done
		printf "%s\n" $i
	done
	read
}

function game_info() {
	printf "\e[$[MH+1];0fHráč: $USER (Nejlepší výkon: $TOP_SCORE)"
	printf "\e[$[MH+1];$[MW-12]fSkóre: %5d" $SCORE
}

########
# MAIN #
########

exec 2>/dev/null
trap at_exit ERR EXIT 
if [ -f $CONFIG ] ; then
	TOP_SCORE=$(cat $CONFIG)
else
	TOP_SCORE=0
fi
title_screen
new_level
move
while :
do
	read -rsn3 -d '' PRESS
	KEY=${PRESS:2}
done

