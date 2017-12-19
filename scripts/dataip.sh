#!/bin/bash
filelogs="/var/log/apache2/access.log"
csv="/var/www/csvhtml.csv"

#crontab running every hour this script
#0 * * * * /home/dataip.sh > /dev/null 2>&1

#delete data of last hour
echo -n "" > $csv

#read each ip from the logs where the hour = -1 hour
grep "$(date -d -1hour +'%Y:%H')" $filelogs | grep -oE "^((25[0-9]|2[0-4][0-9]|0|1?[0-9][0-9]?)\.){3}(25[0-9]|2[0-4][0-9]|0|1?[0-9][0-9]?)" | sort -u | while read line
do
	#wget the infos of the ip
	echo -n $(wget "http://ip-api.com/csv/$line") >> $csv
	echo $'\n' >> $csv
done
