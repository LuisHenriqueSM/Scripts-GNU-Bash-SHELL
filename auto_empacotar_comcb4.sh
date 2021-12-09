#!/bin/bash

DIRE=/home/cbers/auto_empacotar/auto
at -l > $DIRE/auto.txt

rm -rf $DIRE/aquaprog
rm -rf $DIRE/nppprog
rm -rf $DIRE/cbersprog
rm -rf $DIRE/terraprog
rm -rf $DIRE/dmcprog
rm -rf $DIRE/amz1prog
rm -rf $DIRE/cb4aprog

clear
echo " "
echo "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
echo "|||||||||  Ferramenta para agendar envio automatico!  |||||||||"
echo "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
echo " "
echo "INDIQUE QUAL SATELITE  ( CBERS4A ou AMZ1( Para Amazonia-1) ou pressione ENTER para os demais satelites)) "
read SATELITE

if [ -z SATELITE ];
then

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

fi



case $SATELITE in

'AMAZONIA')
clear
echo " "
echo "--------------------------------------------"
echo " ENTRE COM O HORARIO DE INICIO DE GRAVACAO"
echo "--------------------------------------------"
echo " "
echo "Digite o dia! (01, 02, ..., 31)"
read DIA1
echo " "
echo "Digite o mes! (01 para janeiro, 02 para fevereiro, etc...)"
read MES1
echo " "
echo "Digite o ano (aaaa)!"
read ANO1
echo " "
echo "Digite a hora! (01, 02, ..., 23)"
read HORA1
echo " "
echo "Digite os minutos! (00, 01, ..., 59)"
read MIN1
echo " "
echo "Digite os segundos (00, 01, ..., 59)!"
read SEG1
echo " "



TMPO2=$((10#$MIN1 + 16));
TMPO3=$((10#$TMPO2 / 60));
MIN2=$((10#$TMPO2 % 60));
HORA2=$(($HORA1 + $TMPO3));


if [ $MIN2 -lt 10 ];
then
MIN2=`echo "0"$MIN2`;
fi

echo "cp /vdp3/VHR3/1/1/1/"$ANO1"-"$MES1"-"$DIA1"T"$HORA1":"$MIN1":*/999_999_999_00000.raw /storage2020/AMAZONIA_1_WFI_RAW_"$ANO1"_"$MES1"_"$DIA1"."$HORA1"_"$MIN1"_"$SEG1"_ETC2" > $DIRE/AMZ1$ANO1$MES1$DIA1$HORA1$MIN1.txt

at -f $DIRE/AMZ1$ANO1$MES1$DIA1$HORA1$MIN1.txt $HORA2:$MIN2 $MES1$DIA1$ANO1
echo "AMAZONIA_1_WFI_RAW_"$ANO1"_"$MES1"_"$DIA1"."$HORA1"_"$MIN1"_"$SEG1"_ETC2" >> $DIRE/amz1prog


;;

'CBERS4A')
clear
echo " "
echo "--------------------------------------------"
echo " ENTRE COM O HORARIO DE INICIO DE GRAVACAO"
echo "--------------------------------------------"
echo " "
echo " "
echo "Este canal é 1 (para DTS1) ou 2 (para DTS2)?"
read DT
case $DT in
'1')
DTS=`echo "DTS1"`
;;
'2')
DTS=`echo "DTS2"`
;;
esac


echo " "
echo "Digite o dia! (01, 02, ..., 31)"
read DIA1
echo " "
echo "Digite o mes! (01 para janeiro, 02 para fevereiro, etc...)"
read MES1
echo " "
echo "Digite o ano (aaaa)!"
read ANO1
echo " "
echo "Digite a hora! (01, 02, ..., 23)"
read HORA1
echo " "
echo "Digite os minutos! (00, 01, ..., 59)"
read MIN1
echo " "
echo "Digite os segundos (00, 01, ..., 59)!"
read SEG1
echo " "



TMPO2=$((10#$MIN1 + 16));
TMPO3=$((10#$TMPO2 / 60));
MIN2=$((10#$TMPO2 % 60));
HORA2=$(($HORA1 + $TMPO3));


if [ $MIN2 -lt 10 ];
then
MIN2=`echo "0"$MIN2`;
fi

#echo "ponto 1"
echo "cp /vdp"$DT"/VHR"$DT"/2/1/1/"$ANO1"-"$MES1"-"$DIA1"T"$HORA1":"$MIN1":*/999_999_999_00000.raw /storage2020/CBERS_4A_"$DTS"_RAW_"$ANO1"_"$MES1"_"$DIA1"."$HORA1"_"$MIN1"_"$SEG1"_ETC2" > $DIRE/CB4A$ANO1$MES1$DIA1$HORA1$MIN1$DTS.txt

#echo "ponto 2"
at -f $DIRE/CB4A$ANO1$MES1$DIA1$HORA1$MIN1$DTS.txt $HORA2:$MIN2 $MES1$DIA1$ANO1
#echo $DIA1"-"$HORA1"-"$MIN1"-CBERS_4A_"$DTS"_RAW_"$ANO1"_"$MES1"_"$DIA1"."$HORA1"_"$MIN1"_"$SEG1"_ETC2" >> $DIRE/cb4aprog
echo "CBERS_4A_"$DTS"_RAW_"$ANO1"_"$MES1"_"$DIA1"."$HORA1"_"$MIN1"_"$SEG1"_ETC2" >> $DIRE/cb4aprog

;;
esac

#echo "ponto 3"

more $DIRE/nppprog 2> /dev/null
more $DIRE/aquaprog 2> /dev/null
more $DIRE/cbersprog 2> /dev/null
more $DIRE/terraprog 2> /dev/null
more $DIRE/dmcprog 2> /dev/null
more $DIRE/amz1prog 2> /dev/null
more $DIRE/cb4aprog 2> /dev/null

exit

