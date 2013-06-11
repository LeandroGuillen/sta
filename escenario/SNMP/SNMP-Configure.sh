#!/bin/bash

user=`whoami`
directory=`pwd`

if [ "$user" != "root" ]; then
	echo "$user is not an administrator"
	exit 1 

fi


cd $HOME

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

echo -n '¿Agente (snmpd) o manejador (trapd)? (a/m): '
read var1


if [ "$var1" == "a" ]; then

	echo -n "Ip del manejador para enviar traps: "
	read ipManejador
	
	echo "$ipManejador manejador.com" >> /etc/hosts

	cp $directory/snmpd.conf  .	
	
	# Crear jerarquia de directorios par a las claves y certificados
	# /usr/local/shared/snmpd/tls

	cp -r $directory/tlsagente/tls /usr/local/share/snmp

	# Cambiar los permisos a agente.key y agente.crt
	chmod 600 /usr/local/share/snmp/tls/private/agente.key
	chmod 600  /usr/local/share/snmp/tls/certs/agente.crt

	snmpd -r -u alumno -f -Leo -c $HOME/snmpd.conf udp:161 tlstcp:10161 dtlsudp:10161

else # Configurar el manejador

	# Si no existe el directorio (no estamos en el  mismo agente)
	if [ ! -d "/usr/local/share/snmp/tls" ]; then

		cp -r $directory/tlsmanejador/tls /usr/local/share/snmp
	else
		# Copiar solo las claves
		cp $directory/tlsmanejador/tls/private/manejador.key /usr/local/share/snmp/tls/private
	fi

	# Cambiar los permisos a agente.key y agente.crt
	chmod 600 /usr/local/share/snmp/tls/private/manejador.key
	chmod 600  /usr/local/share/snmp/tls/certs/manejador.crt
	
	cp $directory/snmptrapd.conf  .	

    echo -n "Ip del agente ( x.x.x.x agente.com en hosts): "
	read ipAgente

    echo "$ipAgente agente.com" >> /etc/hosts

	snmptrapd -f -Leo -c snmptrapd.conf
fi

