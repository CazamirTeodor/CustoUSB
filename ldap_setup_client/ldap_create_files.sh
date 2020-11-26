#!/bin/bash

egrep -q '\b(([0-9]|[0-9]{2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[0-9]{2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b' <<< $1
if [ $? -eq 0 ]
then
	egrep -q '\b([a-zA-Z0-9]+\.){1,2}([a-z]{2,3})\b' <<< $2
	if [ $? -eq 0 ]
	then
		echo -e "$1\t$2" > ./ldap_files/ldap_host.txt
		domain_parts=$(echo $2 | tr "." "\n")
		domain_ldap=""
		for part in $domain_parts
		do
		    domain_ldap+="dc=$part,"
		done
		domain_ldap=${domain_ldap::-1}
		echo -e "ldap://$1/\n$domain_ldap\ncn=admin,$domain_ldap\n" > ./ldap_files/credentials.txt
		sed -ri "s|.*(^base).*|base $domain_ldap|" ./ldap_files/ldap.conf
		sed -ri "s|.*(^uri).*|uri ldap://$1/|" ./ldap_files/ldap.conf
		sed -ri "s|.*(^ldap_version).*|ldap_version 3|" ./ldap_files/ldap.conf
		sed -ri "s|.*(^rootbinddn).*|rootbinddn cn=admin,$domain_ldap|" ./ldap_files/ldap.conf
		sed -ri "s|.*(^pam_password).*|pam_password md5|" ./ldap_files/ldap.conf
	else
		echo -e "$2 is not a domain name!"
	fi
else
	echo -e "$1 is not an IPv4 address!"
fi
