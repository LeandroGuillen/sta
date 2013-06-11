 #!/bin/bash

directory=`pwd`


user=`whoami`

if [ "$user" != "root" ]; then
	echo "$user is not an administrator"
	exit 1 

fi

ping -c 1 www.google.es

if [ "$?" != "0" ]; then

	echo "There is no connection. Check internet connection."
	exit 1
fi

cp asterisk-10.9.0.tar.gz $HOME
cp asterisk-1.8.5.0.tar.gz $HOME

cd $HOME

apt-get update

apt-get -y install libxml2
apt-get -y install libxml2-dev
apt-get -y install openssl
apt-get -y install libncurses*
apt-get -y install libnewt*
apt-get -y install libsqlite3*

# Para tls
apt-get -y install build-essential
apt-get -y install openssl*
apt-get -y install libcrypt*
apt-get -y install libgcrypt11*

#wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-10.9.0.tar.gz

echo -n "Version a instalar (1= 1.8.5.0 , 2=10.9.0):"
read version
if [ "$version" == "1" ]; then
	tar -xzvf asterisk-1.8.5.0.tar.gz
	cd asterisk-1.8*

else 
	tar -xzvf asterisk-10.9.0.tar.gz
	cd asterisk-10*
fi

./configure
make menuselect
make
make install
make config
make samples

cp $directory/sip.conf  /etc/asterisk/
cp -r $directory/keys /etc/asterisk/

# Crear los certificados de asterisk

mkdir /etc/asterisk/keys

echo -n "IP de asterisk: "
read ipasterisk

if [ "$version" == "1" ]; then
    /root/asterisk-1.8.5.0/contrib/scripts/ast_tls_cert -C "$ipasterisk" -O "UM" -d /etc/asterisk/keys/

else 
    /root/asterisk-10.9.0/contrib/scripts/ast_tls_cert -C "$ipasterisk" -O "UM" -d /etc/asterisk/keys/
fi

cp /etc/asterisk/keys/ca.crt ./certs

/etc/init.d/asterisk start
/etc/init.d/asterisk status


 
