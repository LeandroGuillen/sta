#!/bin/sh

ca=$1
cliente1=$2
cliente2=$3


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

# Crear clave y solicitud del servidor Asterisk
openssl req -new -nodes -newkey rsa:1024 -keyout key-$ca.pem -out req-$ca.pem

# Firmar certificado del servidor Asterisk
openssl ca -keyfile demoCA/private/cakey.pem -in req-$ca.pem -out cert-$ca.pem

# Crear clave y solicitud del cliente 1
openssl req -new -nodes -newkey rsa:1024 -keyout key-$cliente1.pem -out req-$cliente1.pem

# Firmar certificado del cliente 1
openssl ca -keyfile demoCA/private/cakey.pem -in req-$cliente1.pem -out cert-$cliente1.pem

# Crear clave y solicitud del cliente 2
openssl req -new -nodes -newkey rsa:1024 -keyout key-$cliente2.pem -out req-$cliente2.pem

# Firmar certificado del cliente 2
openssl ca -keyfile demoCA/private/cakey.pem -in req-$cliente2.pem -out cert-$cliente2.pem

