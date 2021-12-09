#!/bin/bash
#Script para consultar os logs dos arquivos enviados

clear
cd /mnt/disco1/LOGS


echo "Executanto script para gerar htmls dos arquivos enviados..."
EMPACOTADIR=/mnt/disco1/LOGS

echo "<html>" > $EMPACOTADIR/enviados.html
echo "<head>" >> $EMPACOTADIR/enviados.html
echo "</head>" >> $EMPACOTADIR/enviados.html
echo "<body>" >> $EMPACOTADIR/enviados.html

echo -e "<h2 style=\"text-align:center;\">" >> $EMPACOTADIR/enviados.html
echo "  PAGINA PARA MONITORAMENTO DE ENVIO DE ARQUIVOS  <br />" >> $EMPACOTADIR/enviados.html
echo "</h2>" >> $EMPACOTADIR/enviados.html



#TODOS
cd /mnt/disco1/LOGS
echo -e "<h1 style=\"text-align:center;\">" >> $EMPACOTADIR/enviados.html
echo " 	PARA SIR21 <br />" >> $EMPACOTADIR/enviados.html
echo "</h1>" >> $EMPACOTADIR/enviados.html
echo -e "<h3>" >> $EMPACOTADIR/enviados.html
tac enviados.txt | head -600 > tmp.tmp


echo  "<table border="1" align=center >"  >> $EMPACOTADIR/enviados.html 
echo  "    <tr>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center>  Nome do Arquivo  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center >  Inicio do Envio  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center >  Fim do Envio  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center >  Tamanho do Arquivo  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center >  Checksum  </td>"  >> $EMPACOTADIR/enviados.html
echo  "    </tr>"  >> $EMPACOTADIR/enviados.html


for ((i=600; i>=1; i--))
do
LINHA=`cat tmp.tmp |head -1`
sed -i 1d tmp.tmp
LINHAH=`echo $LINHA"<br />"`
#echo $LINHAH >> $EMPACOTADIR/enviados.html
NOMEAQ=`echo $LINHA | awk -F "-" '{print ($1)}'`
DIA1=`echo $LINHA | awk -F "-" '{print ($3)}' | awk -F "==" '{print ($1)}'`
HORA1=`echo $LINHA | awk -F "-" '{print ($3)}' | awk -F "==" '{print ($2)}'`
DIA2=`echo $LINHA | awk -F "-" '{print ($5)}' | awk -F "==" '{print ($1)}'`
HORA2=`echo $LINHA | awk -F "-" '{print ($5)}' | awk -F "==" '{print ($2)}'`

case $NOMEAQ in
'LANDSAT')
NOMEAQ1=`echo $LINHA | awk -F "-" '{print ($1)}'`
NOMEAQ2=`echo $LINHA | awk -F "-" '{print ($2)}'`
NOMEAQ=`echo $NOMEAQ1-$NOMEAQ2`
DIA1=`echo $LINHA | awk -F "-" '{print ($4)}' | awk -F "==" '{print ($1)}'`
HORA1=`echo $LINHA | awk -F "-" '{print ($4)}' | awk -F "==" '{print ($2)}'`
DIA2=`echo $LINHA | awk -F "-" '{print ($6)}' | awk -F "==" '{print ($1)}'`
HORA2=`echo $LINHA | awk -F "-" '{print ($6)}' | awk -F "==" '{print ($2)}'`
;;
esac



TAMA=`du -h /mnt/sir21/enviados/$NOMEAQ 2> /dev/null  |awk -F " " '{print ($1)}'`
#TAMA=`du -h /mnt/storage2020/$NOMEAQ 2> /dev/null  |awk -F " " '{print ($1)}'`
CHEK=`echo "OK"`
if [ -z $TAMA ]
then
TAMA=`du -h /mnt/sir21/enviados/$NOMEAQ 2> /dev/null  |awk -F " " '{print ($1)}'`
	if [ -z $TAMA ]
	then
	TAMA=`du -h /mnt/sir21/$NOMEAQ 2> /dev/null  |awk -F " " '{print ($1)}'`
	CHEK=`echo "OK"`
	fi

	if [ -z $TAMA ]
        then
        TAMA=`echo "REMOVIDO"`
        CHEK=`echo "OK"`
        fi

fi

echo  "    <tr>"  >> $EMPACOTADIR/enviados.html
echo  "        <td>  "$NOMEAQ "  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td>  "$DIA1 " "$HORA1 "  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td>  "$DIA2 " "$HORA2 "  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center >  "$TAMA "  </td>"  >> $EMPACOTADIR/enviados.html
echo  "        <td align=center >  "$CHEK "  </td>"  >> $EMPACOTADIR/enviados.html
echo  "    </tr>"  >> $EMPACOTADIR/enviados.html

done
echo "</table>" >> $EMPACOTADIR/enviados.html
echo "</h3>" >> $EMPACOTADIR/enviados.html
rm -rf $EMPACOTADIR/tmp.tmp




echo "</body>" >> $EMPACOTADIR/enviados.html
echo "</html>" >> $EMPACOTADIR/enviados.html


cp $EMPACOTADIR/enviados.html /mnt/disco1/SCC/

exit
