#!/bin/bash

#script para enviar automaticamente arquivos da pasta AUTOEMPACOTAR do storage para CP via VPN alternativa VPN2

#Variaveis

DIRE1=/mnt/disco1/A1
DIRE2=/mnt/disco1/A1/AUTOEMPACOTAR
DDD=`date +%H%M%S`
mkdir /mnt/disco1/A1/AUTOEMPACOTAR_TMP/$DDD
DIRE3=/mnt/disco1/A1/AUTOEMPACOTAR_TMP/$DDD
DIRE4=/mnt/disco1/A1/AUTOEMPACOTAR_TMP


echo ". " >> $DIRE1/autolog
echo ". " >> $DIRE1/autolog
echo ". " >> $DIRE1/autolog
echo ". " >> $DIRE1/autolog
echo ". " >> $DIRE1/autolog



date >> $DIRE1/autolog
echo "1comecou aqui.........................." >> $DIRE1/autolog
echo "2variaveis ok" >> $DIRE1/autolog
echo "3usando diretorio abaixo" >> $DIRE1/autolog

#echo $DDD >> $DIRE1/autolog

#listar arquivos a serem enviados
VERIFICA=`ls $DIRE2`

if [ -z $VERIFICA ]
then
echo "AUTOEMPACOTAR VAZIO" >> $DIRE1/autolog
rm -rf /mnt/disco1/A1/AUTOEMPACOTAR_TMP/$DDD
exit
fi

sleep 35

cd $DIRE2
ARQUIVO=`ls $DIRE2 |head -1`
mv $ARQUIVO $DIRE3/
cd $DIRE3
/usr/local/bin/transfere_fdt.sh $ARQUIVO
mv $ARQUIVO $DIRE1/
cd $DIRE4
rm -rf $DDD

exit



