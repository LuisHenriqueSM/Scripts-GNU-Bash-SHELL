#!/bin/bash
DIRE=/home/cbers/auto_empacotar/auto
EMPACOTADIR=/landsat8/logs
SIR=17
CAMER=AWFI
JOB=$1
cd $DIRE
echo "JOB"
echo $JOB
#LINHA=`more $DIRE/aquaprog |head -1`
#sed -i 1d $DIRE/aquaprog

LINHA=`sed -n "/$JOB/p" $DIRE/aquaprog`
echo "LINHA"
echo $LINHA

DIA=`echo $LINHA |awk -F"-" '{print ($3)}'`
MES=`echo $LINHA |awk -F"-" '{print ($2)}'`
ANO=`echo $LINHA |awk -F"-" '{print ($1)}'`
HORA=`echo $LINHA |awk -F"-" '{print ($4)}'`
MIN=`echo $LINHA |awk -F"-" '{print ($5)}'`
#SEG=

cd /mnt/sir$SIR/disco1/A1/
pwd 
#echo $ANO $MES $DIA $HORA $MIN
DIRETORIO=`ls |grep $ANO-$MES-$DIA-$HORA-$MIN`

SEG=`echo $DIRETORIO |awk -F"-" '{print ($7)}'`

cd $DIRETORIO
#echo $DIRETORIO
ARG1=`ls |grep DRD`



echo " "
 echo ""
        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
        station_drd_to_raw $ARG1 AQUA_CADU_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        nome_arquivo=AQUA_CADU_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        echo ""
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"
        echo ""
        transfere_storage.sh $nome_arquivo

       # INICIO=`date`

        transfere_fdt.sh $nome_arquivo
       # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt 





exit
