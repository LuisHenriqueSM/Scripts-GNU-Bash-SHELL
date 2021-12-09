#!/bin/bash
DIRE=/home/cbers/auto_empacotar/auto
EMPACOTADIR=/landsat8/logs
SIR=17
DISCO1=/mnt/sir$SIR/disco1/A1
CAMER=AWFI
JOB=$1
cd $DIRE

#LINHA=`more $DIRE/nppprog |head -1`
#sed -i 1d $DIRE/nppprog

LINHA=`sed "/$JOB/!d" $DIRE/nppprog`

DIA=`echo $LINHA |awk -F"-" '{print ($3)}'`
MES=`echo $LINHA |awk -F"-" '{print ($2)}'`
ANO=`echo $LINHA |awk -F"-" '{print ($1)}'`
HORA=`echo $LINHA |awk -F"-" '{print ($4)}'`
MIN=`echo $LINHA |awk -F"-" '{print ($5)}'`
#SEG=

echo $LINHA

cd $DISCO1
pwd

DIRETORIO=`ls /mnt/sir$SIR/disco1/A1/ |grep $ANO-$MES-$DIA-$HORA-$MIN`
echo $DIRETORIO

SEG=`echo $DIRETORIO |awk -F"-" '{print ($7)}'`

cd $DISCO1/$DIRETORIO

ARG1=`ls |grep DRD`

echo $ARG1


echo " "
 echo ""
	echo ""
        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
        station_drd_to_raw $ARG1 NPP_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        nome_arquivo=NPP_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        echo ""
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"
        echo ""
        transfere_storage.sh $nome_arquivo

	#INICIO=`date`

        transfere_fdt.sh $nome_arquivo
       # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt





exit
