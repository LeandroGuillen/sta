#!/bin/bash

user=`whoami`

if [ "$user" != "root" ]; then
	echo "$user is not an administrator"
	exit 1 

fi


cd $HOME

# Instalar el telefono

add-apt-repository ppa:savoirfairelinux
apt-get update
apt-get install sflphone-client-gnome
