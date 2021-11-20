#!/usr/bin/bash

rm -rf tmp
mkdir -p tmp
cd tmp
tar -xvzf ../openssl-3.0.0.tar.gz
cd openssl-3.0.0
./Configure -static-libgcc -static-libstdc++ --prefix=$PWD/../openssl --openssldir=$PWD/../openssl
make -j 4
make install 

cd $PWD/../openssl
cp lib64/libssl.a ../../../../lib
cp lib64/libcrypto.a  ../../../../lib
rm -rf ../../../../include/openssl
cp -r include/openssl ../../../../include

