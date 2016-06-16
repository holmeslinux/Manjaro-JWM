#!/bin/bash
#
#######################################################
#                   JOGO DA VELHA                     #
#          DUVIDO QUE VOCE CONSIGA GANHAR!            #
#-----------------------------------------------------#
#                    TIC TAC TOE                      #
#    I WON'T GIVE YOU A CHANCE. YOU'LL NEVER WIN!     #
#######################################################
#                                                     #
#         Leia:    Programacao Shell - Linux          #
#         Autor:   Julio Cezar Neves                  #
#         Editora: Brasport                           #
#         ISBN:    85-7452-076-4                      #
#                                                     #
#######################################################
#  Para qualquer duvida ou esclarecimento sobre este  #
# programa estou as ordens em julio.neves@bigfoot.com #
#-----------------------------------------------------#
#   Any doubt about this program you can find me at   #
#              julio.neves@bigfoot.com                #
#######################################################
# Se voce estiver sob o bash, troque a 1a. linha por  #
#                    #!/bin/bash                      #
#-----------------------------------------------------#
#   If you are running bash change the 1st. line for  #
#                    #!/bin/bash                      #
#######################################################
#    Este foi um meio divertido que encontrei para    #
#  testar a compatibilidade no uso de arrays entre o  #
# bash e o ksh. Se alguem quiser desenvolver a rotina #
#   em que o adversario comeca jogando, sinta-se a    #
#  vontade, porem nao esqueca de mandar-me o modulo   #
#             para incorpora-lo ao meu.               #
#-----------------------------------------------------#
#  This program was developed as a funny way to test  #
#  the compatibility between arrays in ksh and bash.  #
# Feel free for develop the module that the opponent  #
# start playing, but don't forget to send me the new  #
#     routine because I'll attach it at this one.     #
#######################################################
#

Ganhei=0
Empate=0
Bold=`tput bold`
OBold=`tput sgr0`
Cols=`tput cols`
if   [ $Cols -lt 80 -o `tput lines` -lt 25 ]
then
    clear
    echo "O tamanho minimo da janela deve ser 25 linhas e 80 colunas"
    exit 2
    read lixo
fi
Col0=`expr \( $Cols - 46 \) / 2`
Eng=`echo "To play in english use: $Bold\`basename $0\`$OBold -e (default language is portuguese)"`

# Ingles ou Portugues?             English or Portuguese?
if  [ "$1" = -e ]
then
        StrIni[1]="   1   2   3"
        StrIni[2]="1    |   |              +---------+----------+"
        StrIni[3]="  ---+---+---           |  Ties   |   Wins   |"
        StrIni[4]="2    |   |              +---------+----------+"
        StrIni[5]="  ---+---+---           |         |          |"
        StrIni[6]="3    |   |              +---------+----------+"
	StrGan="I   W O N !!!"
	StrEmp="T I E"
	StrLe="Now it's our time to play (RowColumn):"
	StrEr1="At this position already has a -> "
	StrEr2="Write row and column together. I.E. 13 means row 1 and column 3"
	StrFim="Do you want to continue?"
else
        StrIni[1]="   1   2   3"
        StrIni[2]="1    |   |              +---------+----------+"
        StrIni[3]="  ---+---+---           | Empates | Vitorias |"
        StrIni[4]="2    |   |              +---------+----------+"
        StrIni[5]="  ---+---+---           |         |          |"
        StrIni[6]="3    |   |              +---------+----------+"
	StrGan="G A N H E I !!!"
	StrEmp="E M P A T E"
	StrLe="Informe a sua jogada (LinhaColuna):"
	StrEr1="Nesta posicao ja existe um -> "
	StrEr2="Informe Linha e Coluna juntos. Ex: 13 = Linha 1 e Coluna 3"
	StrFim="Deseja continuar?"
fi

Escrever ()
	{
        ColIni=`expr \( $Cols - length "$2" \) / 2`
	tput cup $1 $ColIni
	echo "$2"
	}
Iniciar ()
	{
	Jogo=
	for i in 1 2 3
	do
		for j in 1 2 3
		do
			P[$i$j]=
		done
	done
	clear
	for i in 1 2 3 4 5 6
	do
		tput cup `expr 11 + $i` $Col0
		echo "${StrIni[i]}"
	done
	Seg=`date "+%S"`
	case `expr $Seg % 5` in
		0) Jogo=11 ; Saida=1 ;;
		1) Jogo=13 ; Saida=2 ;;
		2) Jogo=31 ; Saida=3 ;;
		3) Jogo=33 ; Saida=4 ;;
		*) Jogo=22 ; Saida=5 ;;
	esac
	tput cup 16 `expr $Col0 + 29`
	echo $Bold$Empate
	tput cup 16 `expr $Col0 + 40`
	echo $Ganhei$OBold
	}
Jogar ()
	{
	P[$1]=$2
	Lin=`echo $1 | cut -c1`
	Col=`echo $1 | cut -c2`
	Lin=`expr \( $Lin - 1 \) \* 2 + 13`
	Col=`expr \( $Col - 1 \) \* 4 + 3 + $Col0`
	tput cup $Lin $Col
	echo $2
	}
Placar ()
	{
	tput bold
	if  [ $1 = E ]
	then
		Empate=$((Empate+1))
		tput cup 22 $Col0
                echo "$StrEmp"
		tput cup 16 `expr $Col0 + 29`  # Escrevendo Placar
		echo $Empate
	else
		Ganhei=$((Ganhei+1))
		tput cup 22 $Col0
                echo "$StrGan"
		tput cup 16 `expr $Col0 + 40`  # Escrevendo Placar
		echo $Ganhei
		case $2 in
		L)	for j in 1 2 3
			do
				Jogar $i$j X
			done
			;;
		C)	for j in 1 2 3
			do
				Jogar $j$i X
			done
			;;
		D1)	for i in 11 22 33
			do
				Jogar $i X
			done
			;;
		*)	for i in 13 22 31
			do
				Jogar $i X
			done
		esac
	fi
	tput sgr0
	}

# Cuidado com o chefe!             WARNING! The boss is near you!
trap "clear ; exit" 0 2 3


# Jogando                          Playing
while true
do
	Iniciar
	if  [ "$1" != "-e" ]
	then
#		tput cup 3 23
		Escrever 3 "$Eng"
	fi
	Jogar $Jogo X
	Vez=0
	while true
	do
		if [ $Vez -eq 4 ]
		then
			Placar E
			break
		fi
		tput cup 21 $Col0
		echo "$StrLe"
		tput cup 21 `expr $Col0 + 1 + length "$StrLe"`
		tput el
		tput cup 21 `expr $Col0 + 1 + length "$StrLe"`
		read Jogo
		case $Jogo in
		[1-3][1-3])	if  [ ${P[$Jogo]} ] 
				then
					tput cup 22 $Col0
					echo -n "$Bold$StrEr1${P[$Jogo]} <-$OBold"
					read Jogo
					tput cup 22 $ColIni
					tput el
		                        tput cup 21 `expr $Col0 + 1 + length "$StrLe"`
					tput el
					continue
				fi
				Jogar $Jogo O
				Vez=$((Vez+1))
				;;
			 *)	tput cup 22 $Col0
		         	echo -n "$Bold$StrEr2$OBold"
		         	read Jogo
				tput cup 22 $Col0
				tput el
		                tput cup 21 `expr $Col0 + 1 + length "$StrLe"`
				tput el
		         	continue
		esac

		for i in 1 2 3
		do
			LX[i]=0 ; CX[i]=0 ; LO[i]=0 ; CO[i]=0 ; DX[i]=0 ; DO[i]=0
		done
		
		for i in 1 2 3
		do
			for j in 1 2 3
			do
				[ "${P[$i$j]}" = X ] && LX[i]=$((${LX[$i]}+1))
				[ "${P[$i$j]}" = O ] && LO[i]=$((${LO[$i]}+1))
				[ "${P[$j$i]}" = X ] && CX[i]=$((${CX[$i]}+1))
				[ "${P[$j$i]}" = O ] && CO[i]=$((${CO[$i]}+1))
			done
		done
		for i in 11 22 33
		do
			[ "${P[$i]}" = X ] && DX[1]=$((${DX[1]}+1))
			[ "${P[$i]}" = O ] && DO[1]=$((${DO[1]}+1))
		done
		
		for i in 13 22 31
		do
			[ "${P[$i]}" = X ] && DX[2]=$((${DX[2]}+1))
			[ "${P[$i]}" = O ] && DO[2]=$((${DO[2]}+1))
		done

# Pra ganhar                       I wanna win!

		for i in 1 2 3
		do
			LAlinhadas[i]=$((${LX[i]}-${LO[i]}))
			CAlinhadas[i]=$((${CX[i]}-${CO[i]}))
			DAlinhadas[i]=$((${DX[i]}-${DO[i]}))
			if  [ ${LAlinhadas[i]} -eq 2 ]
			then
				for j in 1 2 3
				do
					[ ${P[$i$j]} ] && continue
					Jogo=$i$j
					Jogar $Jogo X
					Placar G L
					break 3
				done
			fi
			if  [ ${CAlinhadas[i]} -eq 2 ]
			then
				for j in 1 2 3
				do
					[ ${P[$j$i]} ] && continue
					Jogo=$j$i
					Jogar $Jogo X
					Placar G C
					break 3
				done
			fi
		done
		if  [ ${DAlinhadas[1]} -eq 2 ]
		then
			for i in 11 22 33
			do
				[ ${P[$i]} ] && continue
				Jogo=$i
				Jogar $Jogo X
				Placar G D1
				break 2
			done
		fi
		if  [ ${DAlinhadas[2]} -eq 2 ]
		then
			for i in 13 22 31
			do
				[ ${P[$i]} ] && continue
				Jogo=$i
				Jogar $Jogo X
				Placar G D2
				break 2
			done
		fi

# Pra nao perder                   I don't wanna lose
		
		for i in 1 2 3
		do
			if  [ ${LAlinhadas[i]} -eq -2 ]
			then
				for j in 1 2 3
				do
					[ ${P[$i$j]} ] && continue
					Jogo=$i$j
					Jogar $Jogo X
					continue 3
				done
			fi
			if  [ ${CAlinhadas[i]} -eq -2 ]
			then
				for j in 1 2 3
				do
					[ ${P[$j$i]} ] && continue
					Jogo=$j$i
					Jogar $Jogo X
					continue 3
				done
			fi
		done
		if  [ ${DAlinhadas[1]} -eq -2 ]
		then
			for i in 11 22 33
			do
				[ ${P[$i]} ] && continue
				Jogo=$i
				Jogar $Jogo X
				continue 2
			done
		fi
		if  [ ${DAlinhadas[2]} -eq -2 ]
		then
			for i in 13 22 31
			do
				[ ${P[$i]} ] && continue
				Jogo=$i
				Jogar $Jogo X
				continue 2
			done
		fi

# Ao ataque!                       Let's attack!

		case $Vez in
			1)  case $Saida in
					1)  [ ${P[33]} ] && Jogo=13 || Jogo=33 ;;
					2)  [ ${P[31]} ] && Jogo=33 || Jogo=31 ;;
					3)  [ ${P[13]} ] && Jogo=11 || Jogo=13 ;;
					4)  [ ${P[11]} ] && Jogo=31 || Jogo=11 ;;
					*)  if  [ ${P[11]} ]
						then
							Jogo=33
						elif [ ${P[33]} ]
						then
							Jogo=11
						elif [ ${P[13]} ]
						then
							Jogo=31
						else
							Jogo=13
						fi
			    esac ;;
			*)  [ $P{[22]} ] &&
				{
					Jogo=
					for i in 1 3
					do
						for j in 1 3
						do
							[ ${P[$i$j]} ] && 
							{
								[ ${P[$j$i]} ] && continue || 
								{
									Jogo=$j$i
									break 2
								}
							} ||
							{
								Jogo=$i$j
								break 2
							}
						done
					done
					[ "$Jogo" ] && 
					{
						Jogar $Jogo X
						continue
					}
					for i in 1 2 3
					do
						for j in 1 2 3
						do
							[ "${P[$i$j]}" ] && continue
							Jogo=$i$j
							break 2
						done
					done
				} || Jogo=22
		esac
		Jogar $Jogo X
	done
	tput cup 23 $Col0
        echo "$StrFim"
	tput cup 23 `expr $Col0 + length "$StrFim" + 1`
	read a
	[ `echo $a | tr n N` = N ] && exit
done
