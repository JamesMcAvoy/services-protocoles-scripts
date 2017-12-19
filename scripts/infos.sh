#!/bin/bash
#*/5 * * * * /home/scripts/infos.sh

dns="carnofluxe.com"
csv="/home/scripts/csvhtml2.csv"

#delete last data
echo -n "" > $csv

#date
echo -n $(date +"Infos de %H:%M:%S") >> $csv
echo -n "," >> $csv

#ping
pingdata=$(ping -c 1 $dns | grep "64 bytes")

if echo $pingdata | grep -q "64 bytes"; then
    pingdata="Paquet envoyé "+$pingdata
else
    pingdata="Erreur de ping"
fi

pingdata=$pingdata","
echo -n $pingdata >> $csv

echo -n "Infos nslookup :," >> $csv

#nslookup
nslookup $dns | while read line
do
	echo -n $line >> $csv
	echo -n "," >> $csv
done

#HTTP
echo -n "Temps réponse HTTP :," >> $csv
{ time wget $dns -q --output-document=/dev/null; } 2> "_tmptime"
echo -n $(grep real "_tmptime") >> $csv

rm "_tmptime"
echo ",Fin" >> $csv

#SSH
scp -p $csv root@192.168.253.129:/var/www
