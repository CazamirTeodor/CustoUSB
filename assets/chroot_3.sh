#!/bin/bash

#linux-image-amd64


if [ $# -eq 0 ]

	then

	echo "Nu au fost introduse argumentele necesare "
	exit 1

else

	touch executa.sh

	echo "#!/bin/bash

	apt-get update && apt-get install --no-install-recommends $1 -y live-boot systemd-sysv" >> executa.sh

	chmod +x executa.sh
	cp executa.sh LIVE_BOOT/chroot
	cat executa.sh
	rm executa.sh
	chroot LIVE_BOOT/chroot bash -c /executa.sh $1
	rm LIVE_BOOT/chroot/executa.sh

fi


