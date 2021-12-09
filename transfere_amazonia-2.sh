#!/bin/bash

########################################################################################
# Script que realiza a conversao de dados no formato DRD_CBERS-4 para DRD_AMZ1 via ms3 #
# Autor: Reuel Junqueira / Joao Guimaraes  | Adequado por Luis Henrique S. Martins     #
# Data: 18/03/2021                                                                     #
########################################################################################
# Define variaveis locais #
path_local='/mnt/sir18/disco1/A1'
path_dir='/amz2'
path_exe=$path_local'/DADOS-AMAZONIA-1-ENVIADOS'
antena='CB11'
#ingestora='SIR1'
passagem=$path_dir'/'$1 

list_dir=`ls -1 $path_dir | grep TM`
 
# Verifica se foram informados todos os parametros #

if [ -z $1 ] || [ $1 == '--list' ] || [ $1 == '--help' ] || [ $1 == '-h' ] || [ $1 == 'lista' ]
then
	echo ' '

	for x in $list_dir 
	do
		echo $x 
	done

                echo -e "
            Selecione uma das passagens acima e 
            Execute o comando conforme o exemplo abaixo (scriot + nome_da_pasta): \033[0;31m
                transfere_amazonia-2.sh TM-2021-04-30-12-27-43 \033[0m" 

else
	if [ -d $passagem  ]
	then
		cd $passagem
		TM_DRD=`ls -1 LANDSAT_5_*DRD*`		 
		data_hora=`echo $TM_DRD |cut -d '_' -f5- `
		echo "copiando dado para SIR-18"
		cp -R $TM_DRD $path_local                
                

		# Definindo o nome dos arquivos
		AMZ_RAW='AMAZONIA_1_WFI_RAW_'$data_hora'_'$antena
		AMZ_DRD='AMAZONIA_1_WFI_DRD_'$data_hora'_'$antena
		
		cd $path_local
		echo " Convertendo para RAW"
	 	station_drd_to_raw $TM_DRD $path_exe/$AMZ_RAW	
				
		echo " Convertendo para DRD"
		station_raw_to_drd  $path_exe/$AMZ_RAW AMAZONIA 1 WFI  $path_exe/$AMZ_DRD
                
                rm -rf $path_exe/$AMZ_RAW
		 
                cd $path_exe
		echo " O dado sera enviado!"
                transfere_local.sh $AMZ_DRD
	fi
fi
exit
