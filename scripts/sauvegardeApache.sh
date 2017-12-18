#!/bin/bash

#0 4 1 * * /home/scripts/sauvegardeApache.sh

tar cvf /home/sauvegardeApache/configApache /etc/apache2
tar cvf /home/sauvegardeApache/vHost /etc/hosts

ssh root@192.168.253.129 'rm /home/sauvegardeApache/configApache'
ssh root@192.168.253.129 'rm /home/sauvegardeApache/vHost'

scp -r -p /home/sauvegardeApache/configApache root@192.168.253.129:/home/sauvegardeApache
scp -r -p /home/sauvegardeApache/vHost root@192.168.253.129:/home/sauvegardeApache
