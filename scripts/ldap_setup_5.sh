#!/bin/bash

#-------------------------
# 2 arguments
#1. $1 ip = 192.168.0.2
#2. $2 domeniu = practica.com
#-------------------------

wget https://github.com/CazamirTeodor/CustoUSB/blob/master/ldap_setup_client.tar.gz?raw=true
mv 'ldap_setup_client.tar.gz?raw=true' ldap_setup_client.tar.gz

tar -xzvf ldap_setup_client.tar.gz 
cd ldap_setup_client/
./ldap_create_files.sh $1 $2
cd ..
sudo cp -r ldap_setup_client LIVE_BOOT/chroot/home/