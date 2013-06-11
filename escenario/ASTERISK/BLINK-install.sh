 #!/bin/bash

wget http://download.ag-projects.com/agp-debian-gpg.key 
sudo apt-key add agp-debian-gpg.key

# Anadir a la lista de repositorios

echo "deb    http://ag-projects.com/ubuntu precise main" >> /etc/apt/sources.list
 
echo "deb-src http://ag-projects.com/ubuntu precise main" >> /etc/apt/sources.list

# Actualizar los repositorios e instalar blink
apt-get update 

apt-get -y install libcrypt*
apt-get -y install libgcrypt11*

apt-get -y install blink

#python setup.py install
