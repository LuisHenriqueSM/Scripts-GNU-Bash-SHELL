#!/bin/bash

#script para transferir usando o NCFTP

EMPACOTADIR=/landsat8/logs


#gerando md5 local
#md5sum $1 > $1.md5_cba

#registrando inicio da transferencia
INICIO=`date +%d/%m==%H:%M:%S`

#enviando dado para SIR21
/home/cbers/ncftp-3.2.5/bin/./ncftpput -R -E -u user -p passwd 10.163.155.191 /dados $1
#/home/cbers/ncftp-3.2.5/bin/./ncftpput -R -E -u transfoper -p cba.inpe 10.163.155.191 /dados $1.md5_cba

#registrando horario de fim da transferencia
echo $1 "- INICIO -" $INICIO  "- FIM -" `date +%d/%m==%H:%M:%S`  >> $EMPACOTADIR/enviados.txt


#copiando md5 para storage
#cp $1.md5_cba /storage2020/md5/


#gerando md5 entregue
#md5sum /sir21/$1 > /storage2020/md5/$1.md5_sir21


exit

