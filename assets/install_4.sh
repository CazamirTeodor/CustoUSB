#!/bin/bash

#-------------------------

	#network-manager net-tools wireless-tools wpagui curl openssh-server openssh-client blackbox xserver-xorg-core xserver-xorg xinit xterm screenfetch screen lxterminal vim gedit nano lxde wget sudo gnupg gnupg2
#-------------------------


if [ $# -eq 0 ]

	then 

	echo "Nu au fost introduse argumentele necesare "
	exit 1

else

	sudo touch executa.sh
	sudo touch set.txt

	echo "1" >> set.txt

	echo "#!/bin/bash

	apt install --no-install-recommends $* -y < set.txt && apt clean
	" >> executa.sh


	chmod +x executa.sh
	cp executa.sh LIVE_BOOT/chroot
	cp set.txt LIVE_BOOT/chroot
	cat executa.sh 
	rm executa.sh set.txt
	chroot LIVE_BOOT/chroot bash -c /executa.sh $1
	rm LIVE_BOOT/chroot/executa.sh LIVE_BOOT/chroot/set.txt	

fi


