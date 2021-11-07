#!/usr/bin/bash

# build
RUSTFLAGS="-C target-feature=-crt-static" cargo build --release --target x86_64-unknown-linux-musl

# install
if [ -d ${QHOME}/${QARCH} ]; then
	echo "DESTINATION=${QHOME}/${QARCH}"
	cp ./target/x86_64-unknown-linux-musl/release/libHelloWorld2.so ${QHOME}/${QARCH}/libHelloWorld2.so
else
	echo "Proceed to manually install built library"
fi
