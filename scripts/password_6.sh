#!/bin/bash

#--------------
# 1 argument
# parola
#--------------

if [ $# -eq 0 ]

	then 

	echo "Nu au fost introduse argumentele necesare "
	exit 1

else

	touch executa.sh

	echo "#!/bin/bash
	
	echo \"root:$1\" | chpasswd

	" >> executa.sh

	chmod +x executa.sh
	cat executa.sh
	mv executa.sh LIVE_BOOT/chroot
	
	chroot LIVE_BOOT/chroot bash -c /executa.sh $1
	rm LIVE_BOOT/chroot/executa.sh
	

fi


