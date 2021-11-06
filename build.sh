#!/usr/bin/bash

if [ -L lib/libssl.a ]; then
	echo "Taking for granted that openssl was already succesfully built"
else
	thirdparty/openssl/build.sh
fi


