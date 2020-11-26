#!/bin/bash

ldapsearch -x -b "dc=practica,dc=com" -H ldap://practica.com
echo; echo
getent passwd
