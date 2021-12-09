

#!/bin/bash

#script para transferir usando o FDT (Java)


nome_arquivo=ARQUIVO_SEM_NOME
EMPACOTADIR=/LOGS
INICIO=`date +%d/%m==%H:%M:%S`
ZERADO=$1
SAT=AMAZONIA-1
echo " "
echo " "
echo "Script para envio dos dados AMAZONIA-1...."
echo " "


if [ -z $ZERADO ]
then
        clear
        echo "###########################################################################################################"
        echo "-----------------------------------------------------------------------------------------------------------"
        echo "-----------------------------------------------------------------------------------------------------------"
        echo "###########################################################################################################"
        echo " "
        echo "POR GENTILEZA! REPITA O COMANDO INFORMANDO O ARQUIVO QUE DESEJA EMPACOTAR (SINTAXE: transfere_amazonia-1.sh <arquivo>)"
        echo " "
        echo "###########################################################################################################"
        echo "-----------------------------------------------------------------------------------------------------------"
        echo "-----------------------------------------------------------------------------------------------------------"
        echo "###########################################################################################################"
        exit
fi


echo " "
echo "DIA (01-31)"
read DIA
echo " "
echo "MES (01-12)"
read MES
echo " "
echo "ANO (AAAA)"
read ANO
echo " "
echo "HORA (00-23)"
read HORA
echo " "
echo "MINUTO (00-59)"
read MIN
echo " "
echo "SEGUNDO (00-59)"
read SEG
echo " "
echo " "





# AMAZONIA-1




        echo ""
        echo "------------------------------"
        echo "Gerando o dado, aguarde..."
        echo "------------------------------"
        echo ""
        nome_arquivo=AMAZONIA_1_WFI_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_ETC2
        cp $1 /mnt/sir10/disco1/A1/enviadas/AMZ/$nome_arquivo
        echo ""
        echo ""

echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"




#        transfere_fdt.sh $nome_arquivo
#        transfere_storage.sh $nome_arquivo

#exit

cd /mnt/sir10/disco1/A1/enviadas/AMZ/


/usr/bin/./ncftpput -R -E -u transfoper -p cba.inpe 10.163.155.191 /dados $nome_arquivo




#md5sum $nome_arquivo > $nome_arquivo.md5_cba
#java -jar /home/cbers/FDT/fdt.jar $nome_arquivo.md5_cba -md5 -ss 124928 -P 35 -N -nolock -c 150.163.134.24 -d /cdsr/VPN
#java -jar /home/cbers/FDT/fdt.jar $nome_arquivo -md5 -ss 124928 -P 15 -iof 3  -nolock -c 150.163.134.24 -d /cdsr/VPN

#rm -rf /mnt/sir13/disco1/A1/enviadas/AMZ/$nome_arquivo.md5_cba

#echo $nome_arquivo >> /home/cbers/fdt.log
#echo `date` >> /home/cbers/fdt.log
#echo " " >> /home/cbers/fdt.log


echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date +%d/%m==%H:%M:%S`  >> $EMPACOTADIR/enviados.txt

#mv $nome_arquivo /mnt/disco1/A1/CBERS4A/enviados/VHR"$VDPN"/$nome_arquivo

exit









