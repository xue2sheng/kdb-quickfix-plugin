#!/usr/bin/bash

rm -rf tmp
mkdir -p tmp
cd tmp
tar -xvzf ../quickfix-1.15.1.tar.gz
# lazy patch
cp ../pugiconfig.hpp quickfix-1.15.1/src/C++/pugiconfig.hpp
cd quickfix-1.15.1
./bootstrap
CXXFLAGS="-static-libgcc -static-libstdc++" LDFLAGS="-static-libgcc -static-libstdc++" ./configure --prefix=$PWD/../quickfix --exec-prefix=$PWD/../quickfix --enable-static --enable-shared --with-openssl=$PWD/../../../openssl/tmp/openssl
make -j 4
make install

cd $PWD/../quickfix
cp lib/lib* ../../../../lib
rm -rf ../../../../include/quickfix
cp -r include/quickfix ../../../../include

