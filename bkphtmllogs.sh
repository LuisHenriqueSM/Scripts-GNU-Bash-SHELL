

#!/bin/bash
#Script para consultar os logs dos arquivos enviados

clear
cd /mnt/disco1/LANDSAT8/logs

echo "script para gerar htmls dos arquivos enviados"
EMPACOTADIR=/mnt/disco1/LANDSAT8/logs
EMPACOTADIR2=/mnt/disco1/LANDSAT8/CB3


echo "<html>" > $EMPACOTADIR/cbers.html
echo "<head>" >> $EMPACOTADIR/cbers.html
echo "</head>" >> $EMPACOTADIR/cbers.html
echo "<body>" >> $EMPACOTADIR/cbers.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS <br />" >> $EMPACOTADIR/cbers.html
echo "</h2>" >> $EMPACOTADIR/cbers.html




#FAZENDO HTML para arquivos que vem da CB3 DARTCOM BANDA X

echo "<html>" > $EMPACOTADIR/cb3.html
echo "<head>" >> $EMPACOTADIR/cb3.html
echo "</head>" >> $EMPACOTADIR/cb3.html
echo "<body>" >> $EMPACOTADIR/cb3.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/cb3.html
echo "  PAGINA PARA MONITORAMENTO <br />" >> $EMPACOTADIR/cb3.html
echo "</h2>" >> $EMPACOTADIR/cb3.html

echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cb3.html
echo "  PROGRAMACAO DARTCOM BANDA-X  <br />" >> $EMPACOTADIR/cb3.html
echo "</h1>" >> $EMPACOTADIR/cb3.html
echo -e "<h3>" >> $EMPACOTADIR/cb3.html
head -150 $EMPACOTADIR2/cb3.txt  >  $EMPACOTADIR/cb3.tmp
head -150 $EMPACOTADIR2/cb3.txt  >  $EMPACOTADIR/cb4.tmp

for ((i=150; i>=1; i--))
do

cat cb3.tmp |head -1 | awk -F"." '{print($1)}' >> $EMPACOTADIR/cb3.html
#sed -i 1d cb3.tmp
TTT=`cat cb3.tmp |head -1 | awk -F"-" '{print($1)}' | awk -F" " '{print($1)}'`
FFF=`echo " "`
case $TTT in
'Aqua')
FFF=`echo "         ----------------------------------RECEBER NA ERG"`
;;
'SUOMI')
FFF=`echo "         ----------------------------------RECEBER NA ERG"`
;;
esac

sed -i 1d cb3.tmp

echo $FFF >> $EMPACOTADIR/cb3.html
echo "<br />" >> $EMPACOTADIR/cb3.html

done
echo "</h3>" >> $EMPACOTADIR/cb3.html
#rm -rf $EMPACOTADIR/cb3.tmp






#CBERS4
cd /mnt/disco1/LANDSAT8/logs
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " 	CBERS 4 <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 enviados.txt | grep CBERS_4_ | tail -10 >> cbers.tmp


for ((i=10; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp


#CBERS4A
cd /mnt/disco1/LANDSAT8/logs
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo "  CBERS 4A <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 enviados.txt | grep CBERS_4A | tail -10 >> cbers.tmp


for ((i=10; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp





#LANDSAT7
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " LANDSAT 7 <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep LANDSAT_7 | tail -8 >> $EMPACOTADIR/cbers.tmp

for ((i=8; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp








#LANDSAT8
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " LANDSAT 8 <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep LANDSAT-8 | tail -8 >> $EMPACOTADIR/cbers.tmp

for ((i=8; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp






#RS2
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " RESOURCESAT 2 <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep RS2 | tail -10 >> $EMPACOTADIR/cbers.tmp

for ((i=10; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp








#TERRA
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " TERRA <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep TERRA | tail -8 >> $EMPACOTADIR/cbers.tmp

for ((i=8; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp







#AQUA
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " AQUA <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep AQUA | tail -8 >> $EMPACOTADIR/cbers.tmp

for ((i=8; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp







#NPP
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " NPP <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep NPP | tail -8 >> $EMPACOTADIR/cbers.tmp

for ((i=8; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp




#DMC2
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/cbers.html
echo " UK DMC2 <br />" >> $EMPACOTADIR/cbers.html
echo "</h1>" >> $EMPACOTADIR/cbers.html
echo -e "<h3>" >> $EMPACOTADIR/cbers.html
tail -150 $EMPACOTADIR/enviados.txt | grep DMC2 | tail -10 >> $EMPACOTADIR/cbers.tmp

for ((i=10; i>=1; i--))
do
LINHA=`cat cbers.tmp |head -1`
sed -i 1d cbers.tmp
LINHAH=`echo $LINHA"<br />"`
echo $LINHAH >> $EMPACOTADIR/cbers.html
done
echo "</h3>" >> $EMPACOTADIR/cbers.html
rm -rf $EMPACOTADIR/cbers.tmp





echo "</body>" >> $EMPACOTADIR/cbers.html
echo "</html>" >> $EMPACOTADIR/cbers.html


echo "</body>" >> $EMPACOTADIR/cb3.html
echo "</html>" >> $EMPACOTADIR/cb3.html


exit
