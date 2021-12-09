#!/bin/bash

ORIGEM=/testeraw
DESTINO=/testesir21

EMPACOTADIR=/LOGS
INFO="Ja enviado (Sem acao)"

#script para envio autormatico de arquivos baseado na estrutura dos VDPs da ETC2, usando uma "SIR" na ERG
#sintaxe <comando> <nomedoarquivoenviado>

#echo "1"
#echo $INFO

UDIR=`ls -tr | grep Z | tail -1`

#echo "2"
#echo $UDIR

CONFERE=`cat $EMPACOTADIR/etc2done.txt | grep $UDIR`

#echo "3"
#echo $CONFERE

if [ -z $CONFERE ]
then
cp $ORIGEM/$UDIR/999_999_999_00000.raw $DESTINO/$1

INFO="Arquivo Enviado Agora"

#echo "4"
#echo $INFO

echo $UDIR >> $EMPACOTADIR/etc2done.txt


fi

#echo "5"
echo $INFO
echo $UDIR

exit




