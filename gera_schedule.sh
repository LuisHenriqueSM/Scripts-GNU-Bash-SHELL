

#!/bin/bash
#Script para consultar os logs dos arquivos enviados
#Sintaxe usar exemplo:

clear
#echo " "
#echo "Script para gerar a Folha de Passagem"
#echo " "
#echo "MODO de usar:  script.sh <DIA JULIANO> (espaco) <DIA> (espaco) <MES> (espaco) <ANO>"
#echo " OU "
#echo "APENAS script.sh "
#echo " "
#read TESTE


echo " "
echo "########################################"
echo " SCRIPT PARA GERAR FOLHA DE PASSAGEM "
echo "#######################################"
echo " "
echo " DIGITE O DIA JULIANO (ZULU) OU (DIA DO ANO) 001 A 366 "
read DOYATUAL
echo " "
echo " DIGITE O ANO DESEJADO (AAAA) "
read ANOATUAL
echo ok, gerando a folha...


#DOYATUAL=`echo $1`
#DIAATUAL=`echo $2`
#MESATUAL=`echo $3`
#ANOATUAL=`echo $4`


if [ -z $1 ]
        then
        DOYATUAL=`date +%j`
	ANOATUAL=`date +%Y`
	DIAATUAL=`date +%d`
	MESATUAL=`date +%B`

	else
		if [ -z $4 ]
		then
		exit
		fi


fi


HORAATUAL=`date +%H`
MINATUAL=`date +%M`
SEGATUAL=`date +%S`


DIRETORIOUSANDOT=/mnt/disco1/SCC/incoming/tmp
DIRETORIOUSANDO=/mnt/disco1/SCC/incoming
DIRETORIOXML=/mnt/disco1/SCC/XMLs
DIRETORIOHTML=/mnt/disco1/LOGS


rm -rf $DIRETORIOUSANDOT/*
cp -R $DIRETORIOUSANDO/* $DIRETORIOUSANDOT/


echo "script para gerar html da folha de passagem"

CHECKSCC=`ls $DIRETORIOUSANDO/schedule.xml >/dev/null 2>&1`


echo "" >  $DIRETORIOUSANDO/linhafolha

echo "<html>" > $DIRETORIOUSANDO/folha.html
echo "<head>" >> $DIRETORIOUSANDO/folha.html
echo "</head>" >> $DIRETORIOUSANDO/folha.html
echo "<body>" >> $DIRETORIOUSANDO/folha.html

echo -e "<h1 style=\"text-align:center;\">" >> $DIRETORIOUSANDO/folha.html
echo "  CUIABA,  " $DIAATUAL "   " $MESATUAL "   " $ANOATUAL "   -   " $DOYATUAL " <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h1>" >> $DIRETORIOUSANDO/folha.html





# Comecando a olhar o arquivo schedule.xml para montar os horarios dos satelites

cd $DIRETORIOUSANDOT
#gerando listas com infos do XML
cat schedule.xml |grep Satellite | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listasat
cat schedule.xml |grep StartTime | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' | awk -F" " '{print($3)}' > listastarttime
cat schedule.xml |grep EndTime | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' | awk -F" " '{print($3)}' > listaendtime


cd $DIRETORIOUSANDOT
NLIN=`cat listasat |wc -l`


for ((i=$NLIN; i>=1; i--))

do
LA1=`cat listasat |head -1`
sed -i 1d listasat


LA4A=orbita$LA1 
LA4=`cat $LA4A |head -1` 
sed -i 1d $LA4A 


LA5A=base$LA1
LA5=`cat $LA5A |head -1` 
sed -i 1d $LA5A 


LA2B=start$LA1
LA2=`cat $LA2B |head -1 |awk -F" " '{print($1)}'`
sed -i 1d $LA2B


LA6B=msg$LA1
LA6=`cat $LA6B |head -1`
sed -i 1d $LA6B



LA3B=end$LA1
LA3=`cat $LA3B |head -1 |awk -F" " '{print($1)}'`
sed -i 1d $LA3B


if [ -z $LA2 ]
        then
                LA2=`cat listastarttime |head -1`
                sed -i 1d listastarttime
                
fi



if [ -z $LA3 ]
        then
                LA3=`cat listaendtime |head -1`
                sed -i 1d listaendtime
		
fi

if [ -z $LA4 ]
        then
                LA4=`echo "000000"`
fi


if [ -z $LA5 ]
        then
                LA5=`echo "000"`
fi

echo $LA1"  "$LA2" ____"$LA3" ______"$LA4" ______"$LA5"   "$LA6"  <br />  " >> $DIRETORIOUSANDO/linhafolha

done

cp -R $DIRETORIOUSANDO/* $DIRETORIOUSANDOT/
cd $DIRETORIOUSANDOT

#LANDSAT7
echo -e "<h2 style=\"text-align:left;\">" >> $DIRETORIOUSANDO/folha.html
echo " LANDSAT 7 <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo -e "<h2>" >> $DIRETORIOUSANDO/folha.html


#LANDSAT7
cat $DIRETORIOUSANDO/linhafolha |grep LANDSAT7 |awk -F" " '{print($2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)}'  >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo "<br />" >> $DIRETORIOUSANDO/folha.html




#LANDSAT8
echo -e "<h2 style=\"text-align:left;\">" >> $DIRETORIOUSANDO/folha.html
echo " LANDSAT 8 <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo -e "<h2>" >> $DIRETORIOUSANDO/folha.html


#LANDSAT8
cat $DIRETORIOUSANDO/linhafolha |grep LANDSAT8 |awk -F" " '{print($2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)}'  >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo "<br />" >> $DIRETORIOUSANDO/folha.html




#CBERS-4
echo -e "<h2 style=\"text-align:left;\">" >> $DIRETORIOUSANDO/folha.html
echo " CBERS 4 <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo -e "<h2>" >> $DIRETORIOUSANDO/folha.html


#CBERS-4
cat $DIRETORIOUSANDO/linhafolha |grep CBERS-4 |awk -F" " '{print($2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)}'  >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo "<br />" >> $DIRETORIOUSANDO/folha.html




#RESOURCESAT2
echo -e "<h2 style=\"text-align:left;\">" >> $DIRETORIOUSANDO/folha.html
echo " RESOURCESAT 2 <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo -e "<h2>" >> $DIRETORIOUSANDO/folha.html


#RESOURCESAT2
cat $DIRETORIOUSANDO/linhafolha |grep RESOURCESAT2 |awk -F" " '{print($2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)}'  >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo "<br />" >> $DIRETORIOUSANDO/folha.html


#AQUA
echo -e "<h2 style=\"text-align:left;\">" >> $DIRETORIOUSANDO/folha.html
echo " AQUA <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo -e "<h2>" >> $DIRETORIOUSANDO/folha.html


#AQUA
cat $DIRETORIOUSANDO/linhafolha |grep AQUA |awk -F" " '{print($2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)}'  >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo "<br />" >> $DIRETORIOUSANDO/folha.html


#NPP
echo -e "<h2 style=\"text-align:left;\">" >> $DIRETORIOUSANDO/folha.html
echo " NPP <br />" >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo -e "<h2>" >> $DIRETORIOUSANDO/folha.html


#NPP
cat $DIRETORIOUSANDO/linhafolha |grep NPP |awk -F" " '{print($2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)}'  >> $DIRETORIOUSANDO/folha.html
echo "</h2>" >> $DIRETORIOUSANDO/folha.html
echo "<br />" >> $DIRETORIOUSANDO/folha.html






echo "</body>" >> $DIRETORIOUSANDO/folha.html
echo "</html>" >> $DIRETORIOUSANDO/folha.html


NOVODIR=`echo  "/mnt/disco1/SCC/Gerados/"$ANOATUAL"_"$DOYATUAL`
mkdir $NOVODIR
cp -R $DIRETORIOUSANDO/* $NOVODIR/.

echo "" > $DIRETORIOUSANDOT/orbitaLANDSAT7
echo "" > $DIRETORIOUSANDOT/baseLANDSAT7
echo "" > $DIRETORIOUSANDOT/orbitaLANDSAT8
echo "" > $DIRETORIOUSANDOT/baseLANDSAT8
echo "" > $DIRETORIOUSANDOT/orbitaCBERS-4
echo "" > $DIRETORIOUSANDOT/baseCBERS-4
echo "" > $DIRETORIOUSANDOT/orbitaRESOURCESAT2
echo "" > $DIRETORIOUSANDOT/baseRESOURCESAT2
echo "" > $DIRETORIOUSANDOT/orbitaAQUA
echo "" > $DIRETORIOUSANDOT/baseAQUA
echo "" > $DIRETORIOUSANDOT/orbitaNPP
echo "" > $DIRETORIOUSANDOT/baseNPP
echo "" > $DIRETORIOUSANDOT/startLANDSAT7
echo "" > $DIRETORIOUSANDOT/endLANDSAT7
echo "" > $DIRETORIOUSANDOT/startLANDSAT8
echo "" > $DIRETORIOUSANDOT/endLANDSAT8
echo "" > $DIRETORIOUSANDOT/startCBERS-4
echo "" > $DIRETORIOUSANDOT/endCBERS-4
echo "" > $DIRETORIOUSANDOT/startRESOURCESAT2
echo "" > $DIRETORIOUSANDOT/endRESOURCESAT2
echo "" > $DIRETORIOUSANDOT/startAQUA
echo "" > $DIRETORIOUSANDOT/endAQUA
echo "" > $DIRETORIOUSANDOT/startNPP
echo "" > $DIRETORIOUSANDOT/endNPP








exit
