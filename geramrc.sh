#!/bin/bash


DIRATUAL=/landsat8/MRC

cd $DIRATUAL



#function jumpto
#{
#    label=$1
#    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
#    eval "$cmd"
#    
#}




ANOATUAL=`date +%Y`
DOYATUAL=`date +%j`
HORAATUAL=`date +%H`
MINATUAL=`date +%M`
SEGATUAL=`date +%S`

clear

echo "########################################"
echo "###GERACAO DE RELATORIO MRC LANDSAT-8###"
echo "########################################"
echo " "
echo "ATENCAO!"
echo "ESTE EH UM RELATORIO DE CORRECAO? (S para sim)"
echo "Caso nao seja relatorio de correcao, basta teclar enter!"
read VVI
VV=00
case $VVI in
'S')
VV=01
;;
esac



echo " "
echo "Por Favor, digite o DIA do ano ZULU (001-366) da passagem"
read DOYI
echo " "
echo "Digite o ANO"
read ANOI
echo " "
echo " "
# Descobrindo as bases existentes
BASEINTERNA1=`ls *.txt |grep $ANOI$DOYI |tail -1 |awk -F "." '{print substr($1,4,3)}'`
BASEINTERNA2=`ls *.txt |grep $ANOI$DOYI |head -1 |awk -F "." '{print substr($1,4,3)}' |sed "s/$BASEINTERNA1//g"`

# Colocando na ordem, as bases

ZERO=00

TESTEBASE1=`echo $BASEINTERNA1 |awk -F "." '{print substr($1,1,2)}'`
TESTEBASE2=`echo $BASEINTERNA2 |awk -F "." '{print substr($1,1,2)}'`


echo " "

#>/dev/null 2>&1
#colocando as bases

if [ -z $BASEINTERNA2 ]
then
ORBITAB1=`echo $BASEINTERNA1`
TESTEBASE2=99
BASEINTERNA2=999

if [ -z $ORBITAB1 ]
then
echo "NAO FORAM ENCONTRADAS BASES PARA ESSE DIA - EH POSSIVEL Q AINDA NAO TENHA SIDO PROCESSADO!"
exit
fi

fi



if [ $BASEINTERNA1 -lt $BASEINTERNA2 ]
then
ORBITAB1=`echo $BASEINTERNA1`
ORBITAB2=`echo $BASEINTERNA2`

                if [ $TESTEBASE1 -eq $ZERO ]
                then
                ORBITAB1=`echo $BASEINTERNA2`
                ORBITAB2=`echo $BASEINTERNA1`
                fi

                        if [ $TESTEBASE2 -eq $ZERO ]
                        then
                        ORBITAB1=`echo $BASEINTERNA1`
                        ORBITAB2=`echo $BASEINTERNA2`
                        fi


fi



if [ $BASEINTERNA2 -lt $BASEINTERNA1 ]
then
ORBITAB1=`echo $BASEINTERNA2`
ORBITAB2=`echo $BASEINTERNA1`

                if [ $TESTEBASE1 -eq $ZERO ]
                then
                ORBITAB1=`echo $BASEINTERNA2`
                ORBITAB2=`echo $BASEINTERNA1`
                fi

                        if [ $TESTEBASE2 -eq $ZERO ]
                        then
                        ORBITAB1=`echo $BASEINTERNA1`
                        ORBITAB2=`echo $BASEINTERNA2`
                        fi



fi

if [ $BASEINTERNA2 -eq 999 ]
then
ORBITAB2=`echo " "`
fi


echo "FORAM ENCONTRAS AS SEGUINTES BASES: "
echo " "

echo $ORBITAB1"    "$ORBITAB2
echo " "
echo "FAVOR DIGITAR AS ORBITAS NA ORDEM PELA QUAL ELAS FORAM RECEBIDAS!"
echo " "
echo " "




echo "Por Favor, digite o NUMERO da ORBITA REAL da PRIMEIRA passagem"
read ORBITAR1
echo " "
echo " "
echo " "

if [ -z $ORBITAB2 ]
then
echo " "
else
echo "Por Favor, digite o NUMERO da ORBITA REAL da SEGUNDA passagem"
read ORBITAR2
fi
echo " "
echo " "
echo " "



# Descobrindo as bases existentes de novo
#BASEINTERNA1=`ls *.txt |grep $ANOI$DOYI |tail -1 |awk -F "." '{print substr($1,4,3)}'`
#BASEINTERNA2=`ls *.txt |grep $ANOI$DOYI |head -1 |awk -F "." '{print substr($1,4,3)}' |sed "s/$BASEINTERNA1//g" |sed 's//0/g'`

#echo "Descobrindo as bases existentes de novo"
#echo $BASEINTERNA1
#echo $BASEINTERNA2
#read STATUS


if [ $BASEINTERNA2 -eq 999 ]
then




echo " "
echo "#################################################################"
echo "                        CONFERINDO                               "
echo "#################################################################"
echo " "
echo "PRIMEIRA PASSAGEM  "$ORBITAR1"    "$ORBITAB1
echo " "
#echo "&"
#echo " "
#echo "SEGUNDA PASSAGEM   "$ORBITAR2"    "$ORBITAB2
echo "#################################################################"
read ESPERA


#comparando numero de arquivos do mesmo dia para saber se tem uma ou duas bases


NUMOB1=`ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB1 |wc -l`
echo " " > listabases1.tmp
echo " " > listabases2.tmp
ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB1 > listabases1.tmp
#ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB2 > listabases2.tmp

if [ -z $ORBITAB2 ]
then
echo " " > listabases2.tmp
fi




#Fazer arquios tmp com a lista de bases e lista de pontos em cada base


#NUMOB2=`ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB2 |wc -l`

if [ -z $ORBITAB2 ]
then
NUMOB2=`echo " "`
fi

echo " " > basestmp
echo $NUMOB1 > basestmp
#echo $NUMOB2 |sed 's/ //g' >> basestmp
awk 'NF>0' basestmp > basestmp2

INTV=`cat basestmp2 |wc -l`
#rm -rf basestmp
#rm -rf basestmp2

SENSOR=`echo "OLI"`

	#NOME do XML
	NOMEXML=`echo "L8CUB"$ANOI$DOYI$VV".MRC.xml"`
	NOMEXMLP=`echo "L8CUB"$ANOI$DOYI$VV".MRC"`
	echo $NOMEXML
	echo " "
	echo "TECLE ENTER PARA ENVIAR O RELATORIO MRC!"
	read ESPERA

	#Aqui vamos gerar o cabecalho e o inicio do xml

	echo "<IGS_METADATA_REPORT xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"L8_IC_Metadata_Authentication\">" > $DIRATUAL/$NOMEXML
	echo "<METADATA_RECORD_NAME>"$NOMEXMLP"</METADATA_RECORD_NAME>" >> $DIRATUAL/$NOMEXML
	echo "<STATION_ID>CUB</STATION_ID>" >> $DIRATUAL/$NOMEXML
	echo "<SPACECRAFT_ID>LANDSAT_8</SPACECRAFT_ID>" >> $DIRATUAL/$NOMEXML
	echo "<NUMBER_OF_INTERVALS>"$INTV"</NUMBER_OF_INTERVALS>" >> $DIRATUAL/$NOMEXML
	
	
	#Comecando o primeiro intervalo (primeira passagem)
	echo "<INTERVAL>" >> $DIRATUAL/$NOMEXML
	echo "<INTERVAL_NUMBER>1</INTERVAL_NUMBER>" >> $DIRATUAL/$NOMEXML
	echo "<ORBIT>"$ORBITAR1"</ORBIT>" >> $DIRATUAL/$NOMEXML
	echo "<SENSOR_ID>"$SENSOR"</SENSOR_ID>" >> $DIRATUAL/$NOMEXML
	echo "<NUMBER_OF_SCENES>"$NUMOB1"</NUMBER_OF_SCENES>" >> $DIRATUAL/$NOMEXML
	
	
	#Agora vamos preparar as variaveis que faltam numero de cenas
	
	CONTACENA=1
	for ((i=$NUMOB1; i>=1; i--))
	do
	echo "<SCENE>" >> $DIRATUAL/$NOMEXML
	echo "<SCENE_NUMBER>"$CONTACENA"</SCENE_NUMBER>" >> $DIRATUAL/$NOMEXML
	CONTACENA=$(($CONTACENA + 1));
	NOMECENA=`more listabases1.tmp |head -1`
	sed -i 1d listabases1.tmp
	HORACENA=`cat $NOMECENA |grep SCENE_CENTER_TIME |awk -F"=" '{print($2)}' |awk -F"." '{print($1)}' |sed 's/ //g'`
	ROWCENA=`cat $NOMECENA |grep _WRS_ROW |awk -F"=" '{print($2)}' |sed 's/ //g'`
	PATHCENA=`cat $NOMECENA |grep _WRS_PATH |awk -F"=" '{print($2)}' |sed 's/ //g'`
#Falta descobrir criterio para FULL ou PARTIAL
	IFFULL=`echo "FULL"`
	
	#COntinuando o XML em loop de cenas
	echo "<DATE_ACQUIRED>"$ANOI:$DOYI:$HORACENA"</DATE_ACQUIRED>" >> $DIRATUAL/$NOMEXML
	echo "<WRS_PATH>"$PATHCENA"</WRS_PATH>" >> $DIRATUAL/$NOMEXML
	echo "<WRS_ROW>"$ROWCENA"</WRS_ROW>" >> $DIRATUAL/$NOMEXML
	echo "<FULL_PARTIAL_SCENE>"$IFFULL"</FULL_PARTIAL_SCENE>" >> $DIRATUAL/$NOMEXML
#Agora fechando a cena
	echo "</SCENE>" >> $DIRATUAL/$NOMEXML
	done

echo "</INTERVAL>" >> $DIRATUAL/$NOMEXML


		if [ -z $ORBITAB2 ]
		then
		echo "</IGS_METADATA_REPORT>" >> $DIRATUAL/$NOMEXML
		rm -rf listabases1.tmp
		rm -rf listabases2.tmp
		
		echo "enviando o arquivo " $NOMEXML
		echo "..."
		/usr/local/bin/./enviamrc.sh -v $NOMEXML
		
		exit			
		fi


echo "<INTERVAL>" >> $DIRATUAL/$NOMEXML
echo "<INTERVAL_NUMBER>2</INTERVAL_NUMBER>" >> $DIRATUAL/$NOMEXML
echo "<ORBIT>"$ORBITAR2"</ORBIT>" >> $DIRATUAL/$NOMEXML
echo "<SENSOR_ID>"$SENSOR"</SENSOR_ID>" >> $DIRATUAL/$NOMEXML
echo "<NUMBER_OF_SCENES>"$NUMOB2"</NUMBER_OF_SCENES>" >> $DIRATUAL/$NOMEXML


#Agora vamos preparar as variaveis que faltam numero de cenas

        CONTACENA=1
        for ((i=$NUMOB2; i>=1; i--))
        do
        echo "<SCENE>" >> $DIRATUAL/$NOMEXML
        echo "<SCENE_NUMBER>"$CONTACENA"</SCENE_NUMBER>" >> $DIRATUAL/$NOMEXML
        CONTACENA=$(($CONTACENA + 1));
        NOMECENA=`more listabases2.tmp |head -1`
        sed -i 1d listabases2.tmp
        HORACENA=`cat $NOMECENA |grep SCENE_CENTER_TIME |awk -F"=" '{print($2)}' |awk -F"." '{print($1)}' |sed 's/ //g'`
        ROWCENA=`cat $NOMECENA |grep _WRS_ROW |awk -F"=" '{print($2)}' |sed 's/ //g'`
        PATHCENA=`cat $NOMECENA |grep _WRS_PATH |awk -F"=" '{print($2)}' |sed 's/ //g'`
#Falta descobrir criterio para FULL ou PARTIAL
        IFFULL=`echo "FULL"`

        #COntinuando o XML em loop de cenas
        echo "<DATE_ACQUIRED>"$ANOI:$DOYI:$HORACENA"</DATE_ACQUIRED>" >> $DIRATUAL/$NOMEXML
        echo "<WRS_PATH>"$PATHCENA"</WRS_PATH>" >> $DIRATUAL/$NOMEXML
        echo "<WRS_ROW>"$ROWCENA"</WRS_ROW>" >> $DIRATUAL/$NOMEXML
        echo "<FULL_PARTIAL_SCENE>"$IFFULL"</FULL_PARTIAL_SCENE>" >> $DIRATUAL/$NOMEXML
#Agora fechando a cena
        echo "</SCENE>" >> $DIRATUAL/$NOMEXML
        done




echo "</INTERVAL>" >> $DIRATUAL/$NOMEXML
echo "</IGS_METADATA_REPORT>" >> $DIRATUAL/$NOMEXML

rm -rf listabases1.tmp
rm -rf listabases2.tmp

echo "enviando o arquivo " $NOMEXML
echo "..."
/usr/local/bin/./enviamrc.sh -v $NOMEXML

else

echo " "
echo "#################################################################"
echo "                        CONFERINDO                               "
echo "#################################################################"
echo " "
echo "PRIMEIRA PASSAGEM  "$ORBITAR1"    "$ORBITAB1
echo " "
echo "&"
echo " "
echo "SEGUNDA PASSAGEM   "$ORBITAR2"    "$ORBITAB2
echo "#################################################################"
read ESPERA


#comparando numero de arquivos do mesmo dia para saber se tem uma ou duas bases


NUMOB1=`ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB1 |wc -l`
echo " " > listabases1.tmp
echo " " > listabases2.tmp
ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB1 > listabases1.tmp
ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB2 > listabases2.tmp

if [ -z $ORBITAB2 ]
then
echo " " > listabases2.tmp
fi




#Fazer arquios tmp com a lista de bases e lista de pontos em cada base


NUMOB2=`ls *.txt |grep $ANOI$DOYI |grep LO8$ORBITAB2 |wc -l`

if [ -z $ORBITAB2 ]
then
NUMOB2=`echo " "`
fi

echo " " > basestmp
echo $NUMOB1 > basestmp
echo $NUMOB2 |sed 's/ //g' >> basestmp
awk 'NF>0' basestmp > basestmp2

INTV=`cat basestmp2 |wc -l`
#rm -rf basestmp
#rm -rf basestmp2

SENSOR=`echo "OLI"`

        #NOME do XML
        NOMEXML=`echo "L8CUB"$ANOI$DOYI$VV".MRC.xml"`
        NOMEXMLP=`echo "L8CUB"$ANOI$DOYI$VV".MRC"`
        echo $NOMEXML
        echo " "
        echo "TECLE ENTER PARA ENVIAR O RELATORIO MRC!"
        read ESPERA

        #Aqui vamos gerar o cabecalho e o inicio do xml

        echo "<IGS_METADATA_REPORT xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"L8_IC_Metadata_Authentication\">" > $DIRATUAL/$NOMEXML
        echo "<METADATA_RECORD_NAME>"$NOMEXMLP"</METADATA_RECORD_NAME>" >> $DIRATUAL/$NOMEXML
        echo "<STATION_ID>CUB</STATION_ID>" >> $DIRATUAL/$NOMEXML
        echo "<SPACECRAFT_ID>LANDSAT_8</SPACECRAFT_ID>" >> $DIRATUAL/$NOMEXML
        echo "<NUMBER_OF_INTERVALS>"$INTV"</NUMBER_OF_INTERVALS>" >> $DIRATUAL/$NOMEXML


        #Comecando o primeiro intervalo (primeira passagem)
        echo "<INTERVAL>" >> $DIRATUAL/$NOMEXML
        echo "<INTERVAL_NUMBER>1</INTERVAL_NUMBER>" >> $DIRATUAL/$NOMEXML
        echo "<ORBIT>"$ORBITAR1"</ORBIT>" >> $DIRATUAL/$NOMEXML
        echo "<SENSOR_ID>"$SENSOR"</SENSOR_ID>" >> $DIRATUAL/$NOMEXML
        echo "<NUMBER_OF_SCENES>"$NUMOB1"</NUMBER_OF_SCENES>" >> $DIRATUAL/$NOMEXML


        #Agora vamos preparar as variaveis que faltam numero de cenas

        CONTACENA=1
        for ((i=$NUMOB1; i>=1; i--))
        do
        echo "<SCENE>" >> $DIRATUAL/$NOMEXML
        echo "<SCENE_NUMBER>"$CONTACENA"</SCENE_NUMBER>" >> $DIRATUAL/$NOMEXML
        CONTACENA=$(($CONTACENA + 1));
        NOMECENA=`more listabases1.tmp |head -1`
        sed -i 1d listabases1.tmp
        HORACENA=`cat $NOMECENA |grep SCENE_CENTER_TIME |awk -F"=" '{print($2)}' |awk -F"." '{print($1)}' |sed 's/ //g'`
        ROWCENA=`cat $NOMECENA |grep _WRS_ROW |awk -F"=" '{print($2)}' |sed 's/ //g'`
        PATHCENA=`cat $NOMECENA |grep _WRS_PATH |awk -F"=" '{print($2)}' |sed 's/ //g'`
#Falta descobrir criterio para FULL ou PARTIAL
        IFFULL=`echo "FULL"`

        #COntinuando o XML em loop de cenas
        echo "<DATE_ACQUIRED>"$ANOI:$DOYI:$HORACENA"</DATE_ACQUIRED>" >> $DIRATUAL/$NOMEXML
        echo "<WRS_PATH>"$PATHCENA"</WRS_PATH>" >> $DIRATUAL/$NOMEXML
        echo "<WRS_ROW>"$ROWCENA"</WRS_ROW>" >> $DIRATUAL/$NOMEXML
        echo "<FULL_PARTIAL_SCENE>"$IFFULL"</FULL_PARTIAL_SCENE>" >> $DIRATUAL/$NOMEXML
#Agora fechando a cena
        echo "</SCENE>" >> $DIRATUAL/$NOMEXML
        done

echo "</INTERVAL>" >> $DIRATUAL/$NOMEXML


                if [ -z $ORBITAB2 ]
                then
                echo "</IGS_METADATA_REPORT>" >> $DIRATUAL/$NOMEXML
                rm -rf listabases1.tmp
                rm -rf listabases2.tmp
		echo "enviando o arquivo " $NOMEXML
		echo "..."
		/usr/local/bin/./enviamrc.sh -v $NOMEXML



                exit
                fi


echo "<INTERVAL>" >> $DIRATUAL/$NOMEXML
echo "<INTERVAL_NUMBER>2</INTERVAL_NUMBER>" >> $DIRATUAL/$NOMEXML
echo "<ORBIT>"$ORBITAR2"</ORBIT>" >> $DIRATUAL/$NOMEXML
echo "<SENSOR_ID>"$SENSOR"</SENSOR_ID>" >> $DIRATUAL/$NOMEXML
echo "<NUMBER_OF_SCENES>"$NUMOB2"</NUMBER_OF_SCENES>" >> $DIRATUAL/$NOMEXML


#Agora vamos preparar as variaveis que faltam numero de cenas

        CONTACENA=1
        for ((i=$NUMOB2; i>=1; i--))
        do
        echo "<SCENE>" >> $DIRATUAL/$NOMEXML
        echo "<SCENE_NUMBER>"$CONTACENA"</SCENE_NUMBER>" >> $DIRATUAL/$NOMEXML
        CONTACENA=$(($CONTACENA + 1));
        NOMECENA=`more listabases2.tmp |head -1`
        sed -i 1d listabases2.tmp
        HORACENA=`cat $NOMECENA |grep SCENE_CENTER_TIME |awk -F"=" '{print($2)}' |awk -F"." '{print($1)}' |sed 's/ //g'`
        ROWCENA=`cat $NOMECENA |grep _WRS_ROW |awk -F"=" '{print($2)}' |sed 's/ //g'`
        PATHCENA=`cat $NOMECENA |grep _WRS_PATH |awk -F"=" '{print($2)}' |sed 's/ //g'`
#Falta descobrir criterio para FULL ou PARTIAL
        IFFULL=`echo "FULL"`

        #COntinuando o XML em loop de cenas
        echo "<DATE_ACQUIRED>"$ANOI:$DOYI:$HORACENA"</DATE_ACQUIRED>" >> $DIRATUAL/$NOMEXML
        echo "<WRS_PATH>"$PATHCENA"</WRS_PATH>" >> $DIRATUAL/$NOMEXML
        echo "<WRS_ROW>"$ROWCENA"</WRS_ROW>" >> $DIRATUAL/$NOMEXML
        echo "<FULL_PARTIAL_SCENE>"$IFFULL"</FULL_PARTIAL_SCENE>" >> $DIRATUAL/$NOMEXML
#Agora fechando a cena
        echo "</SCENE>" >> $DIRATUAL/$NOMEXML
        done




echo "</INTERVAL>" >> $DIRATUAL/$NOMEXML
echo "</IGS_METADATA_REPORT>" >> $DIRATUAL/$NOMEXML

rm -rf listabases1.tmp
rm -rf listabases2.tmp

echo "enviando o arquivo " $NOMEXML
echo "..."
/usr/local/bin/./enviamrc.sh -v $NOMEXML


fi


exit
