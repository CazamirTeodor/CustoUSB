#!/bin/bash

	apt-get install -y software-properties-common
	add-apt-repository universe
	apt-get update
	apt-get install --no-install-recommends linux-image-generic:amd64 -y live-boot systemd-sysv
