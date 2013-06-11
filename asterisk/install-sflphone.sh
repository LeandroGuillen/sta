#!/bin/bash

add-apt-repository ppa:savoirfairelinux
apt-get update
apt-get install sflphone-gnome 


# Manera alternativa con el codigo fuente

# dependencias (base)
apt-get install libgcc1 autoconf automake libpulse-dev libsamplerate0-dev libcommoncpp2-dev libccrtp-dev libgsm1-dev libspeex-dev libtool libdbus-1-dev libasound2-dev libspeexdsp-dev uuid-dev libexpat1-dev libzrtpcpp-dev libssl-dev libpcre3-dev libyaml-dev libdbus-c++-dev

# dependencias (gnome client)
apt-get install libgcc1 autoconf automake libtool libgconf2-dev libgtk-3-dev libdbus-glib-1-dev libnotify-dev liblog4c-dev gnome-doc-utils rarian-compat libwebkitgtk-3.0-dev

# bajarse el codigo
git clone http://git.sflphone.org/sflphone.git

cd sflphone
cd daemon/libs
./compile_pjsip.sh
cd daemon
./autogen.sh
./configure
make && sudo make install

cd gnome
./autogen.sh
./configure
make && sudo make install
