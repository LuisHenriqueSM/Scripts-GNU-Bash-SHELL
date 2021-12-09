#!/bin/bash

XML1=$1
DIRATUAL=`pwd`

#definição do arquivo xml1 q sera usado como base
	XML1=`ls |grep cfdp_0`

ANOATUAL=`date +%Y`
DOYATUAL=`date +%j`
HORAATUAL=`date +%H`
MINATUAL=`date +%M`
SEGATUAL=`date +%S`

echo ########################################
echo ###GERACAO DE RELATORIO PPR LANDSAT-8###
echo ########################################
echo " "
echo " "
echo "Por Favor, digite o DIA do ano ZULU (001-366) da passagem"
read DOYI
echo " "
echo "Digite o ANO"
read ANOI
echo " "
echo "HORA de INICIO (00-23)"
read HORAI
echo " "
echo "MINUTO de INICIO (00-59)"
read MINI
echo " "
echo "SEGUNDO de INICIO (00-59)"
read SEGI
echo " "
echo "HORA FINAL (00-23)"
read HORAF
echo " "
echo "MINUTO FINAL (00-59)"
read MINF
echo " "
echo "SEGUNDO FINAL (00-59)"
read SEGF
echo " "

#NOME do XML
NOMEXML=`echo "506_CUB_GPR_"$ANOI$DOYI$HORAI$MINI$SEGI"_"$ANOI$DOYI$HORAF$MINF$SEGF"_"$ANOATUAL$DOYATUAL$HORAATUAL$MINATUAL$SEGATUAL"_OPS_MOE.xml"`
echo $NOMEXML
echo " "
echo "TECLE ENTER PARA ENVIAR O RELATORIO PPR!"
read ESPERA

#Aqui vamos gerar o cabecalho e o inicio do xml

echo "<postpass_report xmlns='http://ldcm.nasa.gov/schema/postpassreport' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>" > $DIRATUAL/$NOMEXML
echo "  <primaryHeader>" >> $DIRATUAL/$NOMEXML
echo "    <SCID>506</SCID>" >> $DIRATUAL/$NOMEXML
echo "    <PRODUCT_TYPE>GPR</PRODUCT_TYPE>" >> $DIRATUAL/$NOMEXML
echo "    <GEN_TIME>"$ANOATUAL-$DOYATUAL-$HORAATUAL:$MINATUAL:$SEGATUAL".000</GEN_TIME>" >> $DIRATUAL/$NOMEXML
echo "    <NUM_RECS>1</NUM_RECS>" >> $DIRATUAL/$NOMEXML
echo "    <SOURCE>IC_CUB</SOURCE>" >> $DIRATUAL/$NOMEXML
echo "    <MODE>OPS</MODE>" >> $DIRATUAL/$NOMEXML
echo "  </primaryHeader>" >> $DIRATUAL/$NOMEXML
echo "  <fileBody>" >> $DIRATUAL/$NOMEXML
echo "    <station_status_message>" >> $DIRATUAL/$NOMEXML
echo "      <STATION_ID>CUB</STATION_ID>" >> $DIRATUAL/$NOMEXML
echo "      <TOTAL_CMD_FRAME_COUNT>0</TOTAL_CMD_FRAME_COUNT>" >> $DIRATUAL/$NOMEXML
echo "      <TOTAL_FRAME_COUNT>0</TOTAL_FRAME_COUNT>" >> $DIRATUAL/$NOMEXML
echo "      <UNCERR_CNT>0</UNCERR_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <S_VC00_CNT>0</S_VC00_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <S_VC01_CNT>0</S_VC01_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <S_VC02_CNT>0</S_VC02_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <S_VC05_CNT>0</S_VC05_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <X_VC00_CNT>638539</X_VC00_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <X_VC05_CNT>106132</X_VC05_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <X_VC08_CNT>0</X_VC08_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <X_VC10_CNT>0</X_VC10_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <X_VC12_CNT>0</X_VC12_CNT>" >> $DIRATUAL/$NOMEXML
echo "      <X_VC14_CNT>0</X_VC14_CNT>" >> $DIRATUAL/$NOMEXML
echo "    </station_status_message>" >> $DIRATUAL/$NOMEXML




#gerando lista dir
cat $1 |grep file_dir | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listadir
cat $1 |grep file_name | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listaname
cat $1 |grep file_size | awk -F">" '{print($2)}' | awk -F"<" '{print($1)}' > listasize

#rm listacompleta

NLIN=`more listadir |wc -l`


for ((i=$NLIN; i>=1; i--))
do
LA1=`more listadir |head -1`
sed -i 1d listadir
LA2=`more listaname |head -1`
sed -i 1d listaname
LA3=`more listasize |head -1`
sed -i 1d listasize
LA2T=`echo $LA2 | awk '{print substr($1,4,1)}'`
LA2T2=`echo $LA2 | awk '{print substr($1,25,1)}'`

#esta primeira linha do case refere-se a arquivo TEMP NAK do ano de 2017, por isso esse 7 ai abaixo.
case $LA2T in
'7')


			case $LA2T2 in
			'_')
				AQSTATUS=`echo "NAK"`
				AQCOD=`echo "000"`
				AQNUM=`echo "000"`

				AQHORA=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,9,2)}'`
				AQMIN=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,11,2)}'`
				AQSEG=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,13,2)}'`
				AQMSEG=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,15,1)}'`

				AQDIA=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,7,2)}'`
				AQMES=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,5,2)}'`
				AQANO=`echo $LA2 |awk -F"." '{print($2)}' | awk '{print substr($0,1,4)}'`
			;;

			'.')
				AQSTATUS=`echo "NAK"`
                                AQCOD=`echo $LA2 |awk -F"_" '{print($3)}' |awk -F"." '{print($1)}'`
                                AQNUM=`echo $LA2 |awk -F"_" '{print($3)}' |awk -F"." '{print($2)}'`

                                AQHORA=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,9,2)}'`
                                AQMIN=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,11,2)}'`
                                AQSEG=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,13,2)}'`
                                AQMSEG=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,15,1)}'`

                                AQDIA=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,7,2)}'`
                                AQMES=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,5,2)}'`
                                AQANO=`echo $LA2 |awk -F"." '{print($3)}' | awk '{print substr($0,1,4)}'`
	


			;;
			esac
				TEMPP=`echo $AQMES/$AQDIA/$AQANO`

				AQDOY=`date +%j -d $TEMPP`

				TEMPNAME=$LA2.CUB


;;

'.')

AQSTATUS=`echo "ACK"`
AQCOD=`echo $LA2 |awk '{print substr($0,1,3)}'`
AQNUM=`echo $LA2 |awk '{print substr($0,5,3)}'`


AQHORA=`echo $LA2 |awk '{print substr($0,17,2)}'`
AQMIN=`echo $LA2 |awk '{print substr($0,19,2)}'`
AQSEG=`echo $LA2 |awk '{print substr($0,21,2)}'`
AQMSEG=`echo $LA2 |awk '{print substr($0,23,1)}'`

AQDIA=`echo $LA2 |awk '{print substr($0,15,2)}'`
AQMES=`echo $LA2 |awk '{print substr($0,13,2)}'`
AQANO=`echo $LA2 |awk '{print substr($0,9,4)}'`

TEMPP=`echo $AQMES/$AQDIA/$AQANO`

AQDOY=`date +%j -d $TEMPP`

TEMPNAME=`echo $AQCOD"."$AQNUM"."$AQANO$AQDOY$AQHORA$AQMIN$AQSEG"."$AQMSEG"00.CUB"`

;;

esac





#echo $LA1" "$TEMPNAME" "$LA3 >> listacompleta
#entendendo acima LA1 - Diretorio, TEMPNAME - nome do arquivo e LA3 - Tamanho do arquivo



#continuando a preencher o XML, agora com ciclo do-done

#echo $TEMPNAME
#echo  $LA1'\'
#echo $LA3

XXML=`echo "    <cfdp_status_record>GCF003,"$AQANO"-"$AQDOY"-"$AQHORA":"$AQMIN":"$AQSEG"."$AQMSEG"00,CUB,FILE_"$AQSTATUS",0,"$AQCOD"."$AQNUM","$LA1'\'$TEMPNAME","$AQANO"-"$AQDOY"-"$AQHORA":"$AQMIN":"$AQSEG"."$AQMSEG"00,"$LA3"</cfdp_status_record>"`

echo $XXML >> $DIRATUAL/$NOMEXML

done

#terminando de preencher o XML

echo "  </fileBody>" >> $DIRATUAL/$NOMEXML
echo "</postpass_report>" >> $DIRATUAL/$NOMEXML
rm -rf listadir
rm -rf listaname
rm -rf listasize
/usr/local/bin/./enviappr.sh -v $NOMEXML
exit
