#!/bin/bash



directory=`pwd`

# Comprobar que snmpd esta instalado

snmpd -v
if [ "$?" != "0" ]; then
	echo "Error: NET-SNMP no esta instalado"
	exit 1
fi


sal=`asterisk -vvvvr -x "module show" | grep res_snmp.so`


if [ "$sal" == "" ]; then
	echo "No se encuentra el modulo res_snmp.so"
	#exit 1
fi

# Crear una copia del fichero res_snmp.so antes de modificarlo
cp /etc/asterisk/res_snmp.conf /etc/asterisk/res_snmp_cp.conf

# Borrar el original para ir sobreescribiendolo
rm /etc/asterisk/res_snmp.conf


while  read line
do
	
	if [ "$line" == ";enabled = yes" ];
	then
		echo "enabled = yes" >> /etc/asterisk/res_snmp.conf 
	else
		echo $line >>	/etc/asterisk/res_snmp.conf
	fi
done < /etc/asterisk/res_snmp_cp.conf

# Borrar la copia
rm /etc/asterisk/res_snmp_cp.conf


# Copiar los ficheros de los MIBS a /usr/local/share/snmp/mibs

cp $directory/ASTERISK-MIB.txt /usr/local/share/snmp/mibs
cp $directory/DIGIUM-MIB.txt /usr/local/share/snmp/mibs

# hay que exportar los mibs en todas las consolas

echo "\n(*) NOTA! Realizar  export MIBS=+ASTERISK-MIB  y export MIBS=+DIGIUM-MIB entodas las consolas (export MIBS=all) \n"

#export MIBS=+ASTERISK-MIB
#export MIBS=+DIGIUM-MIB

export MIBS=all

# Reiniciar asterisk

/etc/init.d/asterisk stop
/etc/init.d/asterisk start

echo "\n(*) NOTA! Reinicie el proceso snmpd \n"

snmpwalk -v2c -c public localhost asterisk

