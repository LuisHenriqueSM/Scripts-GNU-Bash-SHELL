#!/bin/bash
#Script para consultar os logs dos arquivos enviados

clear
cd /mnt/disco1/LOGS
#cp /storage2020_LOGS/enviados.txt /mnt/disco1/LOGS/enviados.txt


echo "script para gerar htmls dos arquivos enviados"
EMPACOTADIR=/mnt/disco1/LOGS

echo "<html>" > $EMPACOTADIR/cbers4.html
echo "<head>" >> $EMPACOTADIR/cbers4.html
echo "</head>" >> $EMPACOTADIR/cbers4.html
echo "<body>" >> $EMPACOTADIR/cbers4.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers4.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS DO CBERS-4 <br />" >> $EMPACOTADIR/cbers4.html
echo "</h2>" >> $EMPACOTADIR/cbers4.html





echo "<html>" > $EMPACOTADIR/cbers4a.html
echo "<head>" >> $EMPACOTADIR/cbers4a.html
echo "</head>" >> $EMPACOTADIR/cbers4a.html
echo "<body>" >> $EMPACOTADIR/cbers4a.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers4a.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS DO CBERS-4A <br />" >> $EMPACOTADIR/cbers4a.html
echo "</h2>" >> $EMPACOTADIR/cbers4a.html





echo "<html>" > $EMPACOTADIR/l7.html
echo "<head>" >> $EMPACOTADIR/l7.html
echo "</head>" >> $EMPACOTADIR/l7.html
echo "<body>" >> $EMPACOTADIR/l7.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/l7.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS LANDSAT-7 <br />" >> $EMPACOTADIR/l7.html
echo "</h2>" >> $EMPACOTADIR/l7.html









echo "<html>" > $EMPACOTADIR/l8.html
echo "<head>" >> $EMPACOTADIR/l8.html
echo "</head>" >> $EMPACOTADIR/l8.html
echo "<body>" >> $EMPACOTADIR/l8.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/l8.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS LANDSAT-8 <br />" >> $EMPACOTADIR/l8.html
echo "</h2>" >> $EMPACOTADIR/l8.html










echo "<html>" > $EMPACOTADIR/rs2.html
echo "<head>" >> $EMPACOTADIR/rs2.html
echo "</head>" >> $EMPACOTADIR/rs2.html
echo "<body>" >> $EMPACOTADIR/rs2.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/rs2.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS RESOURCESAT-2 <br />" >> $EMPACOTADIR/rs2.html
echo "</h2>" >> $EMPACOTADIR/rs2.html






#echo "<html>" > $EMPACOTADIR/dmc.html
#echo "<head>" >> $EMPACOTADIR/dmc.html
#echo "</head>" >> $EMPACOTADIR/dmc.html
#echo "<body>" >> $EMPACOTADIR/dmc.html
#
#echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/dmc.html
#echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS UKDMC2 <br />" >> $EMPACOTADIR/dmc.html
#echo "</h2>" >> $EMPACOTADIR/dmc.html











#CBERS4
cd /mnt/disco1/LOGS
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers4.html
echo " 	CBERS 4 <br />" >> $EMPACOTADIR/cbers4.html
echo "</h1>" >> $EMPACOTADIR/cbers4.html
echo -e "<h3>" >> $EMPACOTADIR/cbers4.html
tail -2350 enviados.txt | grep CBERS_4_ | tail -280 >> cbers4.tmp


for ((i=280; i>=1; i--))
do
LINHA=`cat cbers4.tmp |head -1`
sed -i 1d cbers4.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers4.html
done
echo "</h3>" >> $EMPACOTADIR/cbers4.html
rm -rf $EMPACOTADIR/cbers4.tmp




#CBERS4A
cd /mnt/disco1/LOGS
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers4a.html
echo "  CBERS 4A <br />" >> $EMPACOTADIR/cbers4a.html
echo "</h1>" >> $EMPACOTADIR/cbers4a.html
echo -e "<h3>" >> $EMPACOTADIR/cbers4a.html
tail -2350 enviados.txt | grep CBERS_4A | tail -280 >> cbers4a.tmp


for ((i=280; i>=1; i--))
do
LINHA=`cat cbers4a.tmp |head -1`
sed -i 1d cbers4a.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers4a.html
done
echo "</h3>" >> $EMPACOTADIR/cbers4a.html
rm -rf $EMPACOTADIR/cbers4a.tmp







#LANDSAT7
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/l7.html
echo " LANDSAT 7 <br />" >> $EMPACOTADIR/l7.html
echo "</h1>" >> $EMPACOTADIR/l7.html
echo -e "<h3>" >> $EMPACOTADIR/l7.html
tail -2850 $EMPACOTADIR/enviados.txt | grep LANDSAT_7 | tail -280 >> $EMPACOTADIR/cbers5.tmp

for ((i=280; i>=1; i--))
do
LINHA=`cat cbers5.tmp |head -1`
sed -i 1d cbers5.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/l7.html
done
echo "</h3>" >> $EMPACOTADIR/l7.html
rm -rf $EMPACOTADIR/cbers5.tmp








#LANDSAT8
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/l8.html
echo " LANDSAT 8 <br />" >> $EMPACOTADIR/l8.html
echo "</h1>" >> $EMPACOTADIR/l8.html
echo -e "<h3>" >> $EMPACOTADIR/l8.html
tail -2850 $EMPACOTADIR/enviados.txt | grep LANDSAT-8 | tail -280 >> $EMPACOTADIR/l8.tmp

for ((i=280; i>=1; i--))
do
LINHA=`cat l8.tmp |head -1`
sed -i 1d l8.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/l8.html
done
echo "</h3>" >> $EMPACOTADIR/l8.html
rm -rf $EMPACOTADIR/l8.tmp






#RS2
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/rs2.html
echo " RESOURCESAT 2 <br />" >> $EMPACOTADIR/rs2.html
echo "</h1>" >> $EMPACOTADIR/rs2.html
echo -e "<h3>" >> $EMPACOTADIR/rs2.html
tail -2850 $EMPACOTADIR/enviados.txt | grep RS2 | tail -280 >> $EMPACOTADIR/cbers6.tmp

for ((i=280; i>=1; i--))
do
LINHA=`cat cbers6.tmp |head -1`
sed -i 1d cbers6.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/rs2.html
done
echo "</h3>" >> $EMPACOTADIR/rs2.html
rm -rf $EMPACOTADIR/cbers6.tmp





#DMC2
#echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/dmc.html
#echo " UK DMC2 <br />" >> $EMPACOTADIR/dmc.html
#echo "</h1>" >> $EMPACOTADIR/dmc.html
#echo -e "<h3>" >> $EMPACOTADIR/dmc.html
#tail -2850 $EMPACOTADIR/enviados.txt | grep DMC2 | tail -280 >> $EMPACOTADIR/cbers7.tmp
#
#for ((i=280; i>=1; i--))
#do
#LINHA=`cat cbers7.tmp |head -1`
#sed -i 1d cbers7.tmp
#LINHAH=`echo $LINHA"<br />"`
#echo $LINHAH >> $EMPACOTADIR/dmc.html
#done
#echo "</h3>" >> $EMPACOTADIR/dmc.html
#rm -rf $EMPACOTADIR/cbers7.tmp





echo "</body>" >> $EMPACOTADIR/cbers4.html
echo "</html>" >> $EMPACOTADIR/cbers4.html


echo "</body>" >> $EMPACOTADIR/cbers4a.html
echo "</html>" >> $EMPACOTADIR/cbers4a.html


echo "</body>" >> $EMPACOTADIR/l7.html
echo "</html>" >> $EMPACOTADIR/l7.html

echo "</body>" >> $EMPACOTADIR/l8.html
echo "</html>" >> $EMPACOTADIR/l8.html

echo "</body>" >> $EMPACOTADIR/rs2.html
echo "</html>" >> $EMPACOTADIR/rs2.html

#echo "</body>" >> $EMPACOTADIR/dmc.html
#echo "</html>" >> $EMPACOTADIR/dmc.html









exit
