#!/bin/bash
clear
AUTODIR=/home/cbers/auto_empacotar
echo " "
echo "_______________________________"
echo "EXISTE A SEGUINTE PROGRAMACAO:"
echo "_______________________________"
echo "EM: "`date`
echo " "
echo " "
echo "NPP:"
more $AUTODIR/auto/nppprog 2> /dev/null
echo " "
echo " "
echo "AQUA:"
more $AUTODIR/auto/aquaprog 2> /dev/null
echo " "
echo " "
echo "CBERS:"
more $AUTODIR/auto/cbersprog 2> /dev/null
echo " "
echo " "
echo "TERRA:"
more $AUTODIR/auto/terraprog 2> /dev/null
echo " "
echo " "
echo "DMC2:"
more $AUTODIR/auto/dmcprog 2> /dev/null
echo " "


exit
