#!/bin/bash

# 0 3 * * 6 /home/scripts/sauvegarde.sh
                                                                                
date=$(date +"%d-%m")                                                           
save=$(ls /home/sauvegarde)                                                     
rm /home/sauvegarde/$save                                                       
tar cvf /home/sauvegarde/sauvegarde$date /var/www/                              
scp -r -p /home/sauvegarde/sauvegarde$date root@192.168.253.129:/home/sauvegarde
                                                                                
fichier=$(ssh root@192.168.253.129 'find /home/sauvegarde -type f | wc -l')     
if [ $fichier == 8 ] ; then                                                     
last=$(ssh root@192.168.253.129 'ls /home/sauvegarde -tr1 | grep -m 1 ""')      
ssh root@192.168.253.129 'rm /home/sauvegarde/'$last                            
fi                                                                                                                                                              
