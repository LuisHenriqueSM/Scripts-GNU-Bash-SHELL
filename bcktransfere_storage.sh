#!/bin/bash
# Variaveis usadas pelo bbftp para a maquina da DGI

# Variaveis usadas pelo BBFTP PARA O STORAGE ERG


/home/cbers/ncftp-3.2.5/bin/./ncftpput -R -E -u cbers -p cuiabaerg 10.163.155.233 /mnt/disco1/A1 $1 >> /home/cbers/storage.log


echo $1 >> /home/cbers/storage.log
echo `date` >> /home/cbers/storage.log
echo "################################################ " >> /home/cbers/storage.log


exit
