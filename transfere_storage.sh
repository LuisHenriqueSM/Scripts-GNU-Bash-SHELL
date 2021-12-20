#!/bin/bash
# Variaveis usadas pelo bbftp para a maquina da DGI

# Variaveis usadas pelo BBFTP PARA O STORAGE ERG


/home/cbers/ncftp-3.2.5/bin/./ncftpput -R -E -u user -p passwd 10.163.155.230 /mnt/disco0/A1 $1 >> /home/cbers/storage.log


echo $1 >> /home/cbers/storage.log
echo `date` >> /home/cbers/storage.log
echo "################################################ " >> /home/cbers/storage.log


exit
