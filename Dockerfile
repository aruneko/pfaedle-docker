FROM alpine:latest

RUN apk --update --virtual .build-dep add build-base git cmake python \
 && git clone --recurse-submodules https://github.com/ad-freiburg/pfaedle \
 && cd pfaedle \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j \
 && make install \
 && cd ../../ \
 && rm -rf pfaedle \
 && apk del .build-dep \
 && apk add zlib libstdc++ libgomp libgcc \
 && rm -rf /var/cache/apk/*
VOLUME /source
WORKDIR /source
