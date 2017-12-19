#!/bin/bash

dns="127.0.0.1"
csv="/home/csvhtml2.csv"

#ping
pingdata=$(ping -c 1 $dns | grep "64 bytes")

if echo $pingdata | grep -q "64 bytes"; then
    pingdata="Paquet envoyé "+$pingdata
else
    pingdata="Erreur de ping"
fi

pingdata=$pingdata","
echo $pingdata >> $csv

#dig
digdata=$(dig $dns | grep 'IN' | while read line
do
    echo $(cat $1) >> $csv
done)

echo "," >> $csv

#time wget
