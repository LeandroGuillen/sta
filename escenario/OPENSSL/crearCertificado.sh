#! /bin/bash



echo "******************* NOTA: Algunos datos tienen que ser iguales que los de la CA ****************** \n"
echo "       Organization: UM           "
echo "       State y ProvinceName: Murcia"

echo "**********************************************************"

echo " --- Generar la peticion para la CA ---"

echo -n "Nombre salida certificado (.pem): "
read certificado

echo -n "Nombre salida clave privada (.pem): "
read clave


# Generar peticion CSR
openssl req -new -nodes -newkey rsa:1024 -keyout $clave -out peticion.pem

# CA firma la peticion csr
openssl ca -keyfile demoCA/private/cakey.pem -in peticion.pem -out $certificado

# Borrar fichero de peticion
rm peticion.pem

