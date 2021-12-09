#!/bin/bash

#script para transferir usando o FDT (Java)

EMPACOTADIR=/landsat8/logs
INICIO=`date +%d/%m==%H:%M:%S`


md5sum $1 > $1.md5_cba

bbftp -e "put $1.md5_cba /cdsr/VPN/$1.md5_cba " -u cba 150.163.134.24 -m -p 12
bbftp -e "put $1 /cdsr/VPN/$1 " -u cba 150.163.134.24 -m -p 12




rm -rf $1.md5_cba

echo $1 >> /home/cbers/fdt.log
echo `date` >> /home/cbers/fdt.log
echo " " >> /home/cbers/fdt.log


echo $1 "- INICIO -" $INICIO  "- FIM -" `date +%d/%m==%H:%M:%S`  >> $EMPACOTADIR/enviados.txt



exit
