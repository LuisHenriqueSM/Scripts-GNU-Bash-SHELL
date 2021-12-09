#!/bin/bash

LOGDIR=/landsat8/loglandsat8
LOGDIR2=/landsat8/logs
ARQDIR=`pwd`

TESTE=`ls |grep OLI`

if [ -z $TESTE ]
	then
	echo "########################################################## "
	echo "VOCE PODE ESTAR NO DIRETORIO ERRADO - POR FAVOR VERIFIQUE"
	echo "########################################################## "
	exit
fi

echo " "
echo "####################################################################"
echo "####################################################################"
echo " BEM VINDO AO SCRIPT ERG-CUIABA PARA GERAR TAR LANDSAT-8 E ENVIAR PARA CP "    
echo "####################################################################"
echo "####################################################################"
echo " "                                                                   
echo "INICIANDO EM: " `date`                                               
echo " "                                                                   
echo "Gostaria de consultar os ultimos arquivos enviados? (S ou N)"        
read GER                                                                   

case $GER in
'S')        

echo " "
echo "JA FORAM ENVIADOS:"
tail -15 $LOGDIR/enviados.txt
;;                                

's')

echo " "
echo "JA FORAM ENVIADOS:"
tail -15 $LOGDIR/enviados.txt
;;                                

esac

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
echo "DIA DO ANO (001-366) (ZULU ou DOY)"
read DOY
echo " "
#echo "INSTRUMENTO (CBERS=AWFI,MUX,PAN10,PAN5,IRS...LANDSAT=TM...TERRA&AQUA=MODIS...NPP=VIIRS)"
#read CAM
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
echo "SELECIONE A OPCAO DE ENVIO (USE 1 PARA VPN VELHA OU 2 PARA VPN NOVA)"
read VPN
echo " "
echo " "

ls OLI-RT > lsoli.log
ls TIRS-RT > lstirs.log
echo `date` >> report
ls -l OLI-RT >> report
ls -l TIRS-RT >> report

cd $ARQDIR/OLI-RT

# Teste: SE txt tem conteudo ENTAO copia dado para $DIR
if [ -s $ARQDIR/lsoli.log ]
then
        while read line # le cada linha do arquivo
        do
                if [ -s $line ] # teste: SE arquivo nao-zerado ENTAO
                then
			ZZZ=`echo $line |awk -F "." '{print ($1)}'`
			RRR=`echo $line |awk -F "." '{print ($2)}'`
			SSS=`echo $line |awk -F "." '{print substr($3,9,15)}'`
				if [ -s $RRR ]
				then
					echo "ok"
				else
					LINE2=`echo $ZZZ"."$RRR"."$ANO$DOY$SSS"00.CUB"`
					mv $line $LINE2
				fi
                fi

        done < $ARQDIR/lsoli.log

fi


cd $ARQDIR/TIRS-RT

# Teste: SE txt tem conteudo ENTAO copia dado para $DIR
if [ -s $ARQDIR/lstirs.log ]
then
        while read line # le cada linha do arquivo
        do
                if [ -s $line ] # teste: SE arquivo nao-zerado ENTAO
                then
                        ZZZ=`echo $line |awk -F "." '{print ($1)}'`
                        RRR=`echo $line |awk -F "." '{print ($2)}'`
			SSS=`echo $line |awk -F "." '{print substr($3,9,15)}'`
				if [ -s $RRR ]
				then
					echo "ok"
				else
                                        LINE2=`echo $ZZZ"."$RRR"."$ANO$DOY$SSS"00.CUB"`
                                        mv $line $LINE2
                        	fi

                fi

        done < $ARQDIR/lstirs.log

fi

cd $ARQDIR

ARQ=`echo "LANDSAT-8_"$ANO$MES$DIA"_"$HORA$MIN$SEG".tar.gz"`
tar -zcvf $ARQ *RT

#transfere_fdt.sh $ARQ
#transfere_storage.sh $ARQ

case $VPN in
        '1')
        transfere_fdt.sh $ARQ
        transfere_storage.sh $ARQ
	echo `date` >> $LOGDIR/enviados.txt
	echo $ARQ >> $LOGDIR/enviados.txt
        exit
	;;

        '2')
        transfere_storagevpn.sh $ARQ
        echo `date` >> $LOGDIR/enviados.txt
	echo $ARQ >> $LOGDIR/enviados.txt
	exit
	;;
        esac

if [ -z $VPN ]
                then
                echo "############################################################################ "
                echo "A OPCAO DE ENVIO (VPN) PODE ESTAR VAZIA - POR FAVOR VERIFIQUE"
                echo "############################################################################ "
                else
                echo "############################################################################# "
                echo "A OPCAO DE ENVIO (VPN) PODE ESTAR COM ERRO - POR FAVOR VERIFIQUE"
                echo "############################################################################# "
                exit
                fi




exit
