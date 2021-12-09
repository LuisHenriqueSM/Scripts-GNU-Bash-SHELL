#!/bin/bash
#Script para copiar o XML na SCC (schedule) e fazer backup diario e coloca no incoming o XML a ser usado
#executar ./copiar_xml.sh (sem arguemntos para gerar a folha do dia atual, ou)
#executar ./copiar_xml.sh 321 17 Novembro 2017 (para um dia especifico - DOY + DIA + MES + ANO)

DIRETORIOXMLS=/mnt/disco1/SCC/XMLs
DIRETORIOSCC=/mnt/disco1/SCC
DIRUSANDO=/mnt/disco1/SCC/incoming


DOYATUAL=`echo $1`
DIAATUAL=`echo $2`
MESATUAL=`echo $3`
ANOATUAL=`echo $2`

if [ -z $1 ]
        then
        DOYATUAL=`date +%j`
        ANOATUAL=`date +%Y`
        DIAATUAL=`date +%d`
        MESATUAL=`date +%B`
fi


ARQUI=`echo $ANOATUAL"_"$DOYATUAL"_schedule.xml"`
DIR=`echo $ANOATUAL"_"$DOYATUAL`

if [ -d $DIRETORIOSCC/Gerados/$DIR ]
then
echo "diretorio ok"
else
mkdir /mnt/disco1/SCC/Gerados/$DIR
fi 

smbclient //150.163.155.83/etc -U guest --pass "" -c "get schedule.xml $DIRETORIOXMLS/$ARQUI;"



DOYXML=`cat $DIRETORIOXMLS/$ARQUI |grep TaskID |head -1 |awk -F">" '{print($2)}' |awk -F"_" '{print substr($3,1,3)}'`

if [ "$DOYATUAL" != "$DOYXML" ]
	then
	DOYATUAL=$DOYXML
	DIR=`echo $ANOATUAL"_"$DOYATUAL`

		if [ -d $DIRETORIOSCC/Gerados/$DIR ]
		then
		echo "diretorio ok"
		else
		mkdir /mnt/disco1/SCC/Gerados/$DIR
		fi

fi


\cp $DIRETORIOXMLS/$ARQUI $DIRUSANDO/schedule.xml

\cp $DIRETORIOXMLS/$ARQUI /mnt/disco1/SCC/Gerados/$DIR/schedule.xml

DIRETORIOUSANDOT=/mnt/disco1/SCC/Gerados/$DIR

ls nada > $DIRETORIOUSANDOT/orbitaLANDSAT7 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/baseLANDSAT7 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/orbitaLANDSAT8 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/baseLANDSAT8 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/orbitaCBERS-4 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/baseCBERS-4 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/orbitaRESOURCESAT2 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/baseRESOURCESAT2 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/orbitaAQUA > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/baseAQUA > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/orbitaNPP > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/baseNPP > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/startLANDSAT7 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/endLANDSAT7 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/startLANDSAT8 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/endLANDSAT8 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/startCBERS-4 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/endCBERS-4 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/startRESOURCESAT2 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/endRESOURCESAT2 > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/startAQUA > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/endAQUA > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/startNPP > /dev/null 2>&1
ls nada > $DIRETORIOUSANDOT/endNPP > /dev/null 2>&1






exit
