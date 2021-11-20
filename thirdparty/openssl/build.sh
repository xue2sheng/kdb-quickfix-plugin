#!/usr/bin/bash

rm -rf tmp
mkdir -p tmp
cd tmp
tar -xvzf ../openssl-3.0.0.tar.gz
cd openssl-3.0.0
./Configure -static-libgcc -static-libstdc++ --prefix=$PWD/../openssl --openssldir=$PWD/../openssl
make -j 4
make install_sw

cd $PWD/../openssl
cp -r lib64 lib
cp lib/lib* ../../../../lib
rm -rf ../../../../include/openssl
cp -r include/openssl ../../../../include

