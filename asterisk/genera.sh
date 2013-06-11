#!/bin/sh

cp openssl.cnf /usr/lib/ssl

mkdir demoCA
cd demoCA
echo "00" > crlnumber
echo "01" > serial
mkdir newcerts
touch index.txt
mkdir private
openssl req -x509 -newkey rsa:2048 -keyout cakey.pem -days 3650 -out cacert.pem
#openssl req -x509 -newkey rsa:2048 -keyout cakey.pem -days 3650 -out cacert.pem -config ca.conf
cp cakey.pem private
cd ..

for f in $@
do
	# Crear clave y solicitud del servidor Asterisk
	openssl req -new -nodes -newkey rsa:1024 -keyout key-$f.pem -out req-$f.pem
	# Firmar certificado del servidor Asterisk
	openssl ca -keyfile demoCA/private/cakey.pem -in req-$f.pem -out cert-$f.pem
done
