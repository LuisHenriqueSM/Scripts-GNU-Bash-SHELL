#!/bin/bash -x


DIRE=/home/cbers/auto_empacotar/auto
at -l > $DIRE/auto.txt

rm -rf $DIRE/aquaprog
rm -rf $DIRE/nppprog
rm -rf $DIRE/cbersprog
rm -rf $DIRE/terraprog
rm -rf $DIRE/dmcprog

NLIN=`more $DIRE/auto.txt |wc -l`


for ((i=$NLIN; i>=1; i--))
do
LINHA=`more $DIRE/auto.txt |head -1`
sed -i 1d $DIRE/auto.txt
JOB=`echo $LINHA |awk -F" " '{print ($1)}'`
DATE=`echo $LINHA |awk -F" " '{print ($2)}'`
HORAE=`echo $LINHA |awk -F" " '{print ($3)}' |awk -F":" '{print ($1)}'`
MINE=`echo $LINHA |awk -F" " '{print ($3)}' |awk -F":" '{print ($2)}'`


clear
echo " "
echo "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
echo "||||    DIA: "$DATE"       HORA: "$HORAE":"$MINE"       TAREFA No. "$JOB   "  ||||"
echo "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"

HORAG=`date +%H`
MING=`date +%M`
SSG=`date +%S`

YYE=`echo $DATE |awk -F"-" '{print ($1)}'`
MME=`echo $DATE |awk -F"-" '{print ($2)}'`
DDE=`echo $DATE |awk -F"-" '{print ($3)}'`


TMPO2=$((10#$MINE + 16));
TMPO3=$((10#$TMPO2 / 60));
MINE2=$((10#$TMPO2 % 60));
HORAE2=$(($HORAE + $TMPO3));


if [ $MINE2 -lt 10 ];
then
MINE2=`echo "0"$MINE2`;
fi


echo " "
echo " "
echo "POR FAVOR, ESCOLHA O SATELITE PARA ENVIO AUTOMATICO DA PASSAGEM ACIMA: (AQUA, TERRA, DMC2, CBERS ou NPP)"
echo " "
echo "LEMBRANDO QUE QUALQUER INFORMACAO DIFERENTE DESSAS DUAS OPCOES ACIMA DESCARTARA o ENVIO PARA O HORARIO"
read SATE


TEMP11=`echo $HORAE:$MINE`




		case $SATE  in
		'AQUA')

		echo $DATE"---"$TEMP11 " (mais 15 minutos) envio de AQUA " >> enviando.log		
		echo $DIRE/auto2.sh $JOB > $DIRE/$JOB.txt
		at -f $DIRE/$JOB.txt $HORAE2:$MINE2 $MME$DDE$YYE
		echo $DATE-$HORAE-$MINE-$JOB >> $DIRE/aquaprog
		;;


		'TERRA')

                echo $DATE"---"$TEMP11 " (mais 15 minutos) envio de TERRA " >> enviando.log
                echo $DIRE/auto5.sh $JOB > $DIRE/$JOB.txt
                at -f $DIRE/$JOB.txt $HORAE2:$MINE2 $MME$DDE$YYE
                echo $DATE-$HORAE-$MINE-$JOB >> $DIRE/terraprog
                ;;

		'DMC2')

                echo $DATE"---"$TEMP11 " (mais 15 minutos) envio de DMC2 " >> enviando.log
                echo $DIRE/auto6.sh $JOB > $DIRE/$JOB.txt
                at -f $DIRE/$JOB.txt $HORAE2:$MINE2 $MME$DDE$YYE
                echo $DATE-$HORAE-$MINE-$JOB >> $DIRE/dmcprog
                ;;



		'CBERS')
#OBSERVAR QUE EM ACADA SIR TERA QUE TER UMA CAMERA DIFERENTE NO NOME DO ARQUIVO dentro da pasta home edu auto
                echo $DATE"---"$TEMP11 " (mais 15 minutos) envio de CBERS " >> enviando.log
		echo $DIRE/auto4.sh $JOB > $DIRE/$JOB.txt
		at -f $DIRE/$JOB.txt $HORAE2:$MINE2 $MME$DDE$YYE
                echo $DATE-$HORAE-$MINE-$JOB >> $DIRE/cbersprog
                ;;


	

		'NPP')

		echo $DATE"---"$TEMP11 " (mais 15 minutos) envio de NPP " >> enviando.log
		echo $DIRE/auto3.sh $JOB > $DIRE/$JOB.txt
		at -f $DIRE/$JOB.txt $HORAE2:$MINE2 $MME$DDE$YYE
		echo $DATE-$HORAE-$MINE-$JOB >> $DIRE/nppprog
		;;
		esac

done

more $DIRE/nppprog 2> /dev/null
more $DIRE/aquaprog 2> /dev/null
more $DIRE/cbersprog 2> /dev/null
more $DIRE/terraprog 2> /dev/null
more $DIRE/dmcprog 2> /dev/null
exit

