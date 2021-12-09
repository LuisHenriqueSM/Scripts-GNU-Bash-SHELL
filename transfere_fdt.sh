#!/bin/bash

#script para transferir usando o FDT (Java)

EMPACOTADIR=/landsat8/logs
INICIO=`date +%d/%m==%H:%M:%S`


md5sum $1 > $1.md5_cba
java -jar /home/cbers/FDT/fdt.jar $1.md5_cba -md5 -ss 124928 -P 35 -N -nolock -c 150.163.134.24 -d /cdsr/VPN
java -jar /home/cbers/FDT/fdt.jar $1 -md5 -ss 124928 -P 15 -iof 3  -nolock -c 150.163.134.24 -d /cdsr/VPN

rm -rf $1.md5_cba

echo $1 >> /home/cbers/fdt.log
echo `date` >> /home/cbers/fdt.log
echo " " >> /home/cbers/fdt.log


echo $1 "- INICIO -" $INICIO  "- FIM -" `date +%d/%m==%H:%M:%S`  >> $EMPACOTADIR/enviados.txt



exit
