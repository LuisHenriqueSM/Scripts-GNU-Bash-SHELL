

#!/bin/bash
#Script para consultar os logs dos arquivos enviados
#Sintaxe usar exemplo:
#executar ./folhapassagem.sh (sem arguemntos para gerar a folha do dia atual, ou)
#executar ./folhapassagem.sh 321 17 Novembro 2017 (para um dia especifico - DOY + DIA + MES + ANO)

clear

smbclient //150.163.155.83/etc -U guest --pass "" -c "get schedule.xml /mnt/disco1/LANDSAT8/SCC/schedule.xml;"

cp /mnt/disco1/LANDSAT8/SCC/schedule.xml /mnt/disco1/LANDSAT8/SCC/scc.xml

DOYATUAL=`echo $1`
DIAATUAL=`echo $2`
MESATUAL=`echo $3`
ANOATUAL=`echo $4`
if [ -z $1 ]
        then
        DOYATUAL=`date +%j`
	ANOATUAL=`date +%Y`
	DIAATUAL=`date +%d`
	MESATUAL=`date +%B`
fi



cd /mnt/disco1/LANDSAT8/SCC

#ANOATUAL=`date +%Y`
#DOYATUAL=`date +%j`
HORAATUAL=`date +%H`
MINATUAL=`date +%M`
SEGATUAL=`date +%S`
#DIAATUAL=`date +%d`
#MESATUAL=`date +%B`


echo "script para gerar html da folha de passagem"
EMPACOTADIRX=/mnt/disco1/LANDSAT8/SCC
#rm -rf $ANOATUAL/$DOYATUAL
CHECKSCC=`ls $EMPACOTADIRX/scc_$DOYATUAL.xml`

if [ -n $CHECKSCC ]
then
mv $EMPACOTADIRX/scc.xml $EMPACOTADIRX/XML/scc_$DOYATUAL.xml
exit
fi

rm -rf $ANOATUAL/$DOYATUAL
mkdir $ANOATUAL/$DOYATUAL
cd /mnt/disco1/LANDSAT8/SCC/$ANOATUAL/$DOYATUAL
EMPACOTADIR=/mnt/disco1/LANDSAT8/SCC/$ANOATUAL/$DOYATUAL


echo " " >  $EMPACOTADIR/linha.tmp

echo "<html>" > $EMPACOTADIR/folha.html
echo "<head>" >> $EMPACOTADIR/folha.html
echo "</head>" >> $EMPACOTADIR/folha.html
echo "<body>" >> $EMPACOTADIR/folha.html

echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/folha.html
echo "  CUIABA, " $DIAATUAL " " $MESATUAL " " $ANOATUAL " - " $DOYATUAL " <br />" >> $EMPACOTADIR/folha.html
echo "</h1>" >> $EMPACOTADIR/folha.html



#LANDSAT7
echo -e "<h2 style=\"text-align:left;\">" >> $EMPACOTADIR/folha.html
echo " LANDSAT 7 <br />" >> $EMPACOTADIR/folha.html
echo "</h2>" >> $EMPACOTADIR/folha.html
echo -e "<h2>" >> $EMPACOTADIR/folha.html



# Comecando a olhar o arquivo scc.xml para montar os horarios dos satelites

cd $EMPACOTADIRX
#gerando listas com infos do XML
cat scc.xml |grep Satellite | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listasat
cat scc.xml |grep StartTime | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listatime1
cat scc.xml |grep EndTime | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listatime2
cat scc.xml |grep StartTime | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listatime3
#cat scc.xml |grep AntennaID | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listaantenna


NLIN=`cat listasat |wc -l`


for ((i=$NLIN; i>=1; i--))
do
LA1=`cat listasat |head -1`
sed -i 1d listasat
LA2=`cat listatime1 |head -1 | awk '{print substr($3,1,8)}'`
sed -i 1d listatime1
LA3=`cat listatime2 |head -1 | awk '{print substr($3,1,8)}'`
sed -i 1d listatime2
LA4=`cat listatime3 |head -1 | awk '{print substr($2,1,3)}'`
sed -i 1d listatime3


echo $LA1 "  " $LA2 "  " $LA3 "  " $LA4 "<br />" >> $EMPACOTADIR/linhacomdoy.tmp
echo $LA1 "  " $LA2 "  " $LA3 "<br />" >> $EMPACOTADIR/linhasemdoy.tmp

done
#cat $EMPACOTADIR/linhacomdoy.tmp
rm -rf scc_$DOYATUAL.xml
mv scc.xml scc_$DOYATUAL.xml
cd $EMPACOTADIR
cat $EMPACOTADIR/linhacomdoy.tmp |grep $DOYATUAL > $EMPACOTADIR/linhadoyatual.tmp

#echo "linha doy atual"
#cat $EMPACOTADIR/linhadoyatual.tmp
#echo " "
#NLIN=`cat linhadoyatual.tmp |wc -l`
#for ((i=$NLIN; i>=1; i--))
#do
#cat linhadoyatual.tmp >> $EMPACOTADIR/linha.tmp
#sed -i 1d linhadoyatual.tmp
#done

cat $EMPACOTADIR/linhadoyatual.tmp >> $EMPACOTADIR/linha.tmp

#incluindo DOY de amanha no arquivo linha.tmp
TMRW=$((10#$DOYATUAL + 1));
cat $EMPACOTADIR/linhacomdoy.tmp |grep $TMRW >> $EMPACOTADIR/linha.tmp

#echo $DOYATUAL
#echo " "
#echo "linhaaaa"
#cat $EMPACOTADIR/linha.tmp

#LANDSAT7
#cat linha.tmp |grep LANDSAT7 |awk -F" " '{print($2,$3)}' >> $EMPACOTADIR/folha.html
cat $EMPACOTADIR/linha.tmp |grep LANDSAT7 > $EMPACOTADIR/l7.tmp

NLIN=`cat $EMPACOTADIR/l7.tmp |wc -l`
for ((i=$NLIN; i>=1; i--))
do
cat $EMPACOTADIR/l7.tmp  |head -1 |awk -F" " '{print($2,$3)}' >> $EMPACOTADIR/folha.html
echo "<br />" >> $EMPACOTADIR/folha.html
sed -i 1d l7.tmp
done
rm -rf $EMPACOTADIR/l7.tmp
echo "</h2>" >> $EMPACOTADIR/folha.html



echo "<br />" >> $EMPACOTADIR/folha.html
#CBERS-4
echo -e "<h2 style=\"text-align:left;\">" >> $EMPACOTADIR/folha.html
echo " CBERS 4  <br />" >> $EMPACOTADIR/folha.html
echo "</h2>" >> $EMPACOTADIR/folha.html
echo -e "<h2>" >> $EMPACOTADIR/folha.html

#cat linha.tmp |grep CBERS-4 >> $EMPACOTADIR/folha.html
cat $EMPACOTADIR/linha.tmp |grep CBERS-4 > $EMPACOTADIR/cb.tmp

NLIN=`cat cb.tmp |wc -l`
for ((i=$NLIN; i>=1; i--))
do
cat $EMPACOTADIR/cb.tmp  |head -1 |awk -F" " '{print($2,$3,$4)}' >> $EMPACOTADIR/folha.html
echo "<br />" >> $EMPACOTADIR/folha.html
sed -i 1d cb.tmp
done
rm -rf $EMPACOTADIR/cb.tmp
echo "</h2>" >> $EMPACOTADIR/folha.html



echo "<br />" >> $EMPACOTADIR/folha.html
#LANDSAT8
echo -e "<h2 style=\"text-align:left;\">" >> $EMPACOTADIR/folha.html
echo " LANDSAT8  <br />" >> $EMPACOTADIR/folha.html
echo "</h2>" >> $EMPACOTADIR/folha.html
echo -e "<h2>" >> $EMPACOTADIR/folha.html

#cat linha.tmp |grep LANDSAT8 >> $EMPACOTADIR/folha.html
cat $EMPACOTADIR/linha.tmp |grep LANDSAT8 > $EMPACOTADIR/l8.tmp

NLIN=`cat l8.tmp |wc -l`
for ((i=$NLIN; i>=1; i--))
do
cat $EMPACOTADIR/l8.tmp  |head -1 |awk -F" " '{print($2,$3)}' >> $EMPACOTADIR/folha.html
echo "<br />" >> $EMPACOTADIR/folha.html
sed -i 1d l8.tmp
done
rm -rf $EMPACOTADIR/l8.tmp

echo "</h2>" >> $EMPACOTADIR/folha.html



echo "<br />" >> $EMPACOTADIR/folha.html
#RESOURCESAT2
echo -e "<h2 style=\"text-align:left;\">" >> $EMPACOTADIR/folha.html
echo " RESOURCESAT2  <br />" >> $EMPACOTADIR/folha.html
echo "</h2>" >> $EMPACOTADIR/folha.html
echo -e "<h2>" >> $EMPACOTADIR/folha.html

#cat linha.tmp |grep RESOURCESAT2 >> $EMPACOTADIR/folha.html
cat $EMPACOTADIR/linha.tmp |grep RESOURCESAT2 > $EMPACOTADIR/rs2.tmp

NLIN=`cat rs2.tmp |wc -l`
for ((i=$NLIN; i>=1; i--))
do
cat $EMPACOTADIR/rs2.tmp  |head -1 |awk -F" " '{print($2,$3)}' >> $EMPACOTADIR/folha.html
echo "<br />" >> $EMPACOTADIR/folha.html
sed -i 1d rs2.tmp
done
rm -rf $EMPACOTADIR/rs2.tmp

echo "</h2>" >> $EMPACOTADIR/folha.html




echo "<br />" >> $EMPACOTADIR/folha.html
#AQUA
echo -e "<h2 style=\"text-align:left;\">" >> $EMPACOTADIR/folha.html
echo " AQUA  <br />" >> $EMPACOTADIR/folha.html
echo "</h2>" >> $EMPACOTADIR/folha.html
echo -e "<h2>" >> $EMPACOTADIR/folha.html

#cat linha.tmp |grep RESOURCESAT2 >> $EMPACOTADIR/folha.html
cat $EMPACOTADIR/linha.tmp |grep AQUA > $EMPACOTADIR/aq.tmp

NLIN=`cat aq.tmp |wc -l`
for ((i=$NLIN; i>=1; i--))
do
cat $EMPACOTADIR/aq.tmp  |head -1 |awk -F" " '{print($2,$3,$4)}' >> $EMPACOTADIR/folha.html
echo "<br />" >> $EMPACOTADIR/folha.html
sed -i 1d aq.tmp
done
rm -rf $EMPACOTADIR/aq.tmp

echo "</h2>" >> $EMPACOTADIR/folha.html




echo "<br />" >> $EMPACOTADIR/folha.html
#NPP
echo -e "<h2 style=\"text-align:left;\">" >> $EMPACOTADIR/folha.html
echo " NPP  <br />" >> $EMPACOTADIR/folha.html
echo "</h2>" >> $EMPACOTADIR/folha.html
echo -e "<h2>" >> $EMPACOTADIR/folha.html

#cat linha.tmp |grep RESOURCESAT2 >> $EMPACOTADIR/folha.html
cat $EMPACOTADIR/linha.tmp |grep NPP > $EMPACOTADIR/npp.tmp

NLIN=`cat npp.tmp |wc -l`
for ((i=$NLIN; i>=1; i--))
do
cat $EMPACOTADIR/npp.tmp  |head -1 |awk -F" " '{print($2,$3,$4)}' >> $EMPACOTADIR/folha.html
echo "<br />" >> $EMPACOTADIR/folha.html
sed -i 1d npp.tmp
done
rm -rf $EMPACOTADIR/npp.tmp

echo "</h2>" >> $EMPACOTADIR/folha.html





cd /mnt/disco1/LANDSAT8/SCC
#cd /mnt/disco1/LANDSAT8/SCC/$ANOATUAL/$DOYATUAL
rm -rf folha.tmp
rm -rf listatime1
rm -rf listatime2
rm -rf listatime3
rm -rf listasat
rm -rf listaantenna
cd /mnt/disco1/LANDSAT8/SCC/$ANOATUAL/$DOYATUAL
rm -rf linhacomdoy.tmp
rm -rf linha.tmp
rm -rf linhasemdoy.tmp
rm -rf linhadoyatual.tmp


echo "</body>" >> $EMPACOTADIR/folha.html
echo "</html>" >> $EMPACOTADIR/folha.html

exit
