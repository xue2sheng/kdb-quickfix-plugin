#!/usr/bin/bash

mkdir -p tmp
cd tmp
tar -xvzf ../openssl-3.0.0.tar.gz
cd openssl-3.0.0
./Configure -static-libgcc -static-libstdc++
make -j 4
#make test

cp libssl.a ../../../../lib
cp libcrypto.a  ../../../../lib

rm -rf ../../../../include/crypto && cp -r include/crypto ../../../../include
rm -rf ../../../../include/openssl && cp -r include/openssl ../../../../include
rm -rf ../../../../include/internal && cp -r include/internal ../../../../include

