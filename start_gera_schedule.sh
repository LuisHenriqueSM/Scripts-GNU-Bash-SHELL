#!/bin/bash

#script para monitorar e dar start no gera_schedule.sh

DIR=/mnt/disco1/SCC/Start

TESTE=`ls $DIR`

if [ -z $TESTE ]
then
exit
fi

/usr/local/bin/gera_schedule.sh > /dev/null 2>&1

exit






