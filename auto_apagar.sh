#!/bin/bash
DIRE=/home/cbers/auto_empacotar/jobes
AUTODIR=/home/cbers/auto_empacotar
clear
LISTA=`ps -ef |grep $AUTODIR |grep /bin/bash |awk -F" " '{print ($2)}'`

kill -9 $LISTA


at -l > $DIRE/job.txt


NLIN=`more $DIRE/job.txt |wc -l`


for ((i=$NLIN; i>=1; i--))
do
LINHA=`more $DIRE/job.txt |head -1`
sed -i 1d $DIRE/job.txt
JOB=`echo $LINHA |awk -F" " '{print ($1)}'`
atrm $JOB
done

echo `ps -ef |grep $AUTODIR |grep /bin/bash` 2> /dev/null

cd

ls nada* > $AUTODIR/auto/nppprog 2> /dev/null

ls nada* > $AUTODIR/auto/aquaprog 2> /dev/null

ls nada* > $AUTODIR/auto/cbersprog 2> /dev/null

ls nada* > $AUTODIR/auto/terraprog 2> /dev/null

echo " "
echo "#############"
echo "LISTA APAGADA"
echo "#############"

exit
