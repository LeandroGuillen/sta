 #!/bin/bash

echo -n "Version asterisk (1= 1.8.5.0; 2=10.9.0): "
read version

echo -n "Fichero salida (sin extension): "
read fichero

echo -n "IP cliente: "
read ipasterisk

if [ "$version" == "1" ]; then
    /root/asterisk-1.8.5.0/contrib/scripts/ast_tls_cert -m client -c /etc/asterisk/keys/ca.crt -k /etc/asterisk/keys/ca.key -C "$ipasterisk" -O "UM" -d ./certs -o "$fichero"


else 
    /root/asterisk-10.9.0/contrib/scripts/ast_tls_cert -m client -c /etc/asterisk/keys/ca.crt -k /etc/asterisk/keys/ca.key -C "$ipasterisk" -O "UM" -d ./certs -o "$fichero"
fi

rm "./certs/$fichero.csr"
rm "./certs/tmp.cfg"
echo "El fichero $fichero.pem es el que hay que poner en el telefono, junto con el de la ca"
