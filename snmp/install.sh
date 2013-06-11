#!/bin/bash

apt-get update

#apt-get --assume-yes purge libperl*
#apt-get --assume-yes purge libssl*
#apt-get --assume-yes purge openssl*
#apt-get --assume-yes purge openssh-server

# Instalacion de librerias

apt-get --assume-yes install libperl-dev libssl-dev
#apt-get --assume-yes install libssl*
#apt-get --assume-yes install openssl*
#apt-get --assume-yes install openssh-server


# Instalacion de net-snmp

tar -xzvf net-snmp-5.7.2.rc3.tar.gz # Si no funciona descargar 5.7.1

cd net-snmp-5.7.2.rc3
./configure --with-security-modules=tsm --with-transports=TLSTCP,DTLSUDP --with-default-snmp-version="3" --with-sys-contact="sta" --with-sys-location="unknown" --with-logfile="/var/log/snmpd.log" --with-persistent-directory="/var/net-snmp"

# Version 3
# Rellenar con los datos que sean

make
make uninstall
make install

cd ..


# Lanzar el agente (el que sirve la informacion)
# snmpd -f -Leo -c snmpd.conf &

# Lanzar el manejador de traps (el que pregunta, ademas maneja los traps)
# * para usar snmpget o snmpdtrap basta con instalar en el cliente
# * los paquetes 'snmp' y 'snmpd', usando el snmpd.conf y el snmptrapd.conf.
# snmptrapd -f -Leo -c snmptrapd.conf &

#HAY QUE HACER ESTO AL FINALIZAR EN TODAS LAS CONSOLAS QUE SE USEN
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
