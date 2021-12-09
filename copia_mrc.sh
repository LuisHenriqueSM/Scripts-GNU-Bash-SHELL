#!/bin/bash
#Script para consultar os logs dos arquivos enviados

DIR=/home/cbers/
clear

echo " "
echo " "
#echo "####################################################################"
#echo "####################################################################"

cd $DIR
TESTE=`ls |grep MTL.txt`

if [ -z $TESTE ]
then
exit
fi

cp -r $DIR/* /L8/MRC

exit
