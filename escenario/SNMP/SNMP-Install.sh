#!/bin/bash

user=`whoami`

if [ "$user" != "root" ]; then
	echo "$user is not an administrator"
	exit 1 

fi

# Comprobar si hay conexion a internet
ping -c 1 www.google.es

if [ "$?" != 0 ]; then
	echo "Conectate a internet!"
	exit 1
fi

# apt-get update

echo 'Repositorio Actualizado\n'

apt-get  -y install libperl* # apt-get -y install does not work... I dunno why 
apt-get	 -y install libssl*
apt-get  -y install openssl*
apt-get  -y install openssh-server

echo 'Paquetes instalados\n'

cd $HOME

pwd

echo 'Descargando NET-SNMP\n'

wget -O net-snmp-5.7.1.tar.gz 'http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.1/net-snmp-5.7.1.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fnet-snmp%2Ffiles%2Fnet-snmp%2F5.7.1%2Fnet-snmp-5.7.1.tar.gz%2Fdownload&ts=1349197701&use_mirror=garr'

echo 'NET-SNMP descargado\n'

tar -xzvf net-snmp-5.7.1.tar.gz

cd net-snmp-5.7.1

pwd

./configure --with-security-modules=tsm --with-transports=TLSTCP,DTLSUDP

make

make install

#Para evitar un fallo al encontrar las libsnmp

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

echo "Si da fallo al no encontrar las librerias hacer:  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib"








