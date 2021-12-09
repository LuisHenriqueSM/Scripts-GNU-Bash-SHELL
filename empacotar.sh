#!/bin/bash
#Script de teste para ler parametros

#script para gerar RAW a partir de DRD e enviar para CP
clear
echo " "
echo " "
echo "####################################################################"
echo "####################################################################"
echo " BEM VINDO AO SCRIPT ERG-CUIABA PARA GERAR RAW E ENVIAR PARA CP "
echo "####################################################################"
echo "####################################################################"
echo " "
EMPACOTADIR=/landsat8/logs
ZERADO=$1
nome_arquivo=ARQUIVO_SEM_NOME
echo " INICIO " `date`

echo " "
echo " "
echo " "
echo "###################################################################### "
echo "DESEJA RODAR O AUTO_EMPACOTAR.SH? <S - para SIM    ou    N - para NAO>"
echo "###################################################################### "
read MODO
echo " "
echo " "
echo " "
echo " "
case $MODO in
'S')
/usr/local/bin/auto_empacotar.sh
exit
;;

's')
/usr/local/bin/auto_empacotar.sh
exit
;;
esac

TESTE1=`ls |grep DRD |awk -F "_" '{print ($1)}'`

if [ -z $TESTE1 ]
        then
	TESTE2=`ls |grep OLI`
		if [ -z $TESTE2 ]
        	then
        	echo "########################################################## "
        	echo "VOCE PODE ESTAR NO DIRETORIO ERRADO - POR FAVOR VERIFIQUE"
        	echo "########################################################## "
        	exit
		fi
	echo "LANDSAT-8 IDENTIFICADO!"
	echo "APERTE ENTER PARA CONTINUAR!"
	read ESPERA
	/usr/local/bin/landsat8_empacotar.sh
	exit
fi


clear
echo " "
echo "############################################################"
echo "Gostaria de consultar os ultimos arquivos enviados? (S ou N)"
echo "############################################################"
read GER

case $GER in
'S')

echo " "
echo "JA FORAM ENVIADOS:"
tail -20 $EMPACOTADIR/enviados.txt
;;

's')

echo " "
echo "JA FORAM ENVIADOS:"
tail -20 $EMPACOTADIR/enviados.txt
;;

esac


if [ -z $ZERADO ]
then
        clear
	echo "###########################################################################################################"
	echo "-----------------------------------------------------------------------------------------------------------"
	echo "-----------------------------------------------------------------------------------------------------------"   
        echo "###########################################################################################################"
        echo " "
	echo "POR GENTILEZA! REPITA O COMANDO INFORMANDO O ARQUIVO QUE DESEJA EMPACOTAR (SINTAXE: empacotar.sh <arquivo>)"
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
echo "SATELITE (CBERS, LANDSAT7, LANDSAT8, TERRA, AQUA, NPP, DMC2)"
read SAT
echo " "
echo "INSTRUMENTO (CBERS=AWFI,MUX,PAN10,PAN5,IRS...LANDSAT=TM...TERRA&AQUA=MODIS...NPP=VIIRS...DMC2=RAW)"
read CAM
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
echo "SELECIONE O CAMINHO USADO PARA ENVIO (Use (1) para VPN Velha ou (2) para VPN NOVA)"
read VPN
echo " "
echo " "




case $SAT in
'LANDSAT7')
#LANDSAT-7
echo ""

if [ -z $ZERADO ]
then
        echo ""
        echo "VERIFIQUE SE O ARQUIVO QUE DESEJA ENVIAR FOI INFORMADO = empacotar.sh <arquivo>"
        echo ""
        exit
fi


        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
	echo "POR FAVOR INDIQUE O CANAL (I ou Q):"
	read CHN

                case $CHN in
                'I')

                station_drd_to_raw $1 LANDSAT_7_SIR1_RAW_I_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"
                nome_arquivo=LANDSAT_7_SIR1_RAW_I_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"
                ;;

		'Q')

                station_drd_to_raw $1 LANDSAT_7_SIR2_RAW_Q_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"
                nome_arquivo=LANDSAT_7_SIR2_RAW_Q_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"
                ;;
		esac

echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"



  
        # INICIO=`date`
        # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt

        case $VPN in
        '1')
        transfere_fdt.sh $nome_arquivo
        transfere_storage.sh $nome_arquivo
        exit
        ;;

        '2')
        transfere_storagevpn.sh $nome_arquivo
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



	;;

'LANDSAT8')
#LANDSAT-8
echo ""
        echo "------------------------------"
        echo "Executando landsat8_empacotar.sh"
        echo "------------------------------"
        echo ""
	/usr/local/bin/landsat8_empacotar.sh
	exit

       ;;
'CBERS')
#CBERS4

if [ -z $ZERADO ]
then
        echo ""
        echo "VERIFIQUE SE O ARQUIVO QUE DESEJA ENVIAR FOI INFORMADO = empacotar.sh <arquivo>"
        echo ""
        exit
fi



        echo ""
        echo "------------------------------"
        echo "Renomeando o dado DRD, aguarde..."
        echo "------------------------------"
        echo ""

		case $CAM in
		'AWFI')
		
		cp $1 CBERS_4_AWFI_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        	nome_arquivo=CBERS_4_AWFI_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
		;;

		'WFI')

		cp $1 CBERS_4_AWFI_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                nome_arquivo=CBERS_4_AWFI_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                ;;

		'IRS')

		cp $1 CBERS_4_IRS_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                nome_arquivo=CBERS_4_IRS_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                ;;

		'MUX')

		cp $1 CBERS_4_MUX_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                nome_arquivo=CBERS_4_MUX_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                ;;

		'PAN5')

		cp $1 CBERS_4_PAN5M_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                nome_arquivo=CBERS_4_PAN5M_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                ;;

		'PAN10')

		cp $1 CBERS_4_PAN10M_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                nome_arquivo=CBERS_4_PAN10M_DRD_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
                ;;
		esac


echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"



       
        # INICIO=`date`
        # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt

        case $VPN in
        '1')
        transfere_fdt.sh $nome_arquivo
        transfere_storage.sh $nome_arquivo
        exit
        ;;

        '2')
        transfere_storagevpn.sh $nome_arquivo
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



        ;;

'AQUA')
# AQUA

if [ -z $ZERADO ]
then
        echo ""
        echo "VERIFIQUE SE O ARQUIVO QUE DESEJA ENVIAR FOI INFORMADO = empacotar.sh <arquivo>"
        echo ""
        exit
fi


        echo ""
        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
        station_drd_to_raw $1 AQUA_CADU_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        nome_arquivo=AQUA_CADU_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        echo ""
        echo ""

echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"



        # INICIO=`date`
        # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt

        case $VPN in
        '1')
        transfere_fdt.sh $nome_arquivo
        transfere_storage.sh $nome_arquivo
        exit
        ;;

        '2')
        transfere_storagevpn.sh $nome_arquivo
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





        ;;
'TERRA')
# TERRA
echo ""


if [ -z $ZERADO ]
then
        echo ""
        echo "VERIFIQUE SE O ARQUIVO QUE DESEJA ENVIAR FOI INFORMADO = empacotar.sh <arquivo>"
        echo ""
        exit
fi


        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
        station_drd_to_raw $1 TERRA_CADU_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        nome_arquivo=TERRA_CADU_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        echo ""
        echo ""

echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"



        # INICIO=`date`
        # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt

        case $VPN in
        '1')
        transfere_fdt.sh $nome_arquivo
        transfere_storage.sh $nome_arquivo
        exit
        ;;

        '2')
        transfere_storagevpn.sh $nome_arquivo
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




	;;

'NPP')
# NPP

if [ -z $ZERADO ]
then
        echo ""
        echo "VERIFIQUE SE O ARQUIVO QUE DESEJA ENVIAR FOI INFORMADO = empacotar.sh <arquivo>"
        echo ""
        exit
fi


        echo ""
        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
        station_drd_to_raw $1 NPP_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        nome_arquivo=NPP_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"_CB11
        echo ""

echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"



       


        # INICIO=`date`
        # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt

        case $VPN in
        '1')
        transfere_fdt.sh $nome_arquivo
        transfere_storage.sh $nome_arquivo
        exit
        ;;

        '2')
        transfere_storagevpn.sh $nome_arquivo
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





        ;;

'DMC2')
# DMC2

if [ -z $ZERADO ]
then
        echo ""
        echo "VERIFIQUE SE O ARQUIVO QUE DESEJA ENVIAR FOI INFORMADO = empacotar.sh <arquivo>"
        echo ""
        exit
fi


        echo ""
        echo "------------------------------"
        echo "Gerando o dado RAW, aguarde..."
        echo "------------------------------"
        echo ""
        station_drd_to_raw $1 DMC2_SIR17_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"
        nome_arquivo=DMC2_SIR17_RAW_"$ANO"_"$MES"_"$DIA"."$HORA"_"$MIN"_"$SEG"
        echo ""

echo " "
echo " "
        echo "------------------------------------------------------------------------------------------------------------"
        echo "Transferindo o dado $nome_arquivo para backup e CP"
        echo "------------------------------------------------------------------------------------------------------------"


        # INICIO=`date`
        # echo $nome_arquivo "- INICIO -" $INICIO  "- FIM -" `date`  >> $EMPACOTADIR/enviados.txt

        case $VPN in
        '1')
        transfere_fdt.sh $nome_arquivo
        transfere_storage.sh $nome_arquivo
        exit
        ;;

        '2')
        transfere_storagevpn.sh $nome_arquivo
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




        ;;

esac

echo " "

TESTE3=$SAT
                if [ -z $TESTE3 ]
                then
                echo "############################################################################ "
                echo "O VALOR DO CAMPO SATELITE PODE ESTAR EM BRANCO OU NULO - POR FAVOR VERIFIQUE"
                echo "############################################################################ "
                else
		echo "############################################################################# "
                echo "O VALOR DO CAMPO SATELITE PODE TER SIDO DIGITADO ERRADO - POR FAVOR VERIFIQUE"
                echo "############################################################################# "
		exit
                fi



exit
