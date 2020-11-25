#!/bin/bash

ip_address="$(egrep -o '\b(([0-9]|[0-9]{2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[0-9]{2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b' ./ldap_files/ldap_host.txt)"
egrep -q $ip_address /etc/hosts
if [ $? -ne 0 ]
then
	cat ./ldap_files/ldap_host.txt /etc/hosts > temp && mv temp /etc/hosts
else
	sed -i "s/$(egrep $ip_address /etc/hosts)/$(cat ./ldap_files/ldap_host.txt)/" /etc/hosts
fi
sudo apt -y install libnss-ldap libpam-ldap ldap-utils
sudo cp ./ldap_files/ldap.conf /etc/ldap.conf
sudo cp ./ldap_files/nsswitch.conf /etc/nsswitch.conf
sudo cp ./ldap_files/common-password /etc/pam.d/common-password
sudo cp ./ldap_files/mkhomedir /usr/share/pam-configs/mkhomedir
sudo cp ./ldap_files/common-session /etc/pam.d/common-session
