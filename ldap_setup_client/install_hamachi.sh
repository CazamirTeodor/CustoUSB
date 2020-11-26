#!/bin/bash

#install hamachi
wget http://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb
dpkg -i logmein-hamachi_2.1.0.203-1_amd64.deb
hamachi login

#install haguichi
sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/haguichi/ubuntu bionic main" > /etc/apt/sources.list.d/haguichi.list'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886
apt update
apt install -y haguichi