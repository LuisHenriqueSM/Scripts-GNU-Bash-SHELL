#!/bin/bash
# Variaveis usadas pelo bbftp para a maquina da DGI

# Variaveis usadas pelo BBFTP PARA O STORAGE ERG

EMPACOTADIR=/landsat8/logs
INICIO=`date +%d/%m==%H:%M:%S`


/usr/bin/./ncftpput -R -E -u user -p passwd 10.163.155.191 /dados $1


echo $1 >> /home/cbers/fdt.log
echo `date` >> /home/cbers/fdt.log
echo " " >> /home/cbers/fdt.log


echo $1 "- INICIO -" $INICIO  "- FIM -" `date +%d/%m==%H:%M:%S`  >> $EMPACOTADIR/enviados.txt




#echo $1 >> /home/cbers/storage.log
#echo `date` >> /home/cbers/storage.log
#echo "################################################ " >> /home/cbers/storage.log


exit



