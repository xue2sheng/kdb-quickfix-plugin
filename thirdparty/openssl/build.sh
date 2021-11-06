#!/usr/bin/bash

mkdir -p tmp
cd tmp
tar -xvzf ../openssl-3.0.0.tar.gz
cd openssl-3.0.0
./Configure -static-libgcc -static-libstdc++
make -j 4
#make test

ln -s include/crypto ../../../../include
ln -s include/openssl ../../../../include
ln -s include/internal ../../../../include
ln -s libssl.a ../../../../lib
ln -s libcrypto.a  ../../../../lib

