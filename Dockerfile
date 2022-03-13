FROM alpine:3.15

RUN apk add build-base perl

WORKDIR /app

COPY tiny-curl-7.79.1/ .
COPY config/config.sh .

RUN sh config.sh
RUN make
RUN make install

RUN mkdir -p /build/bin /build/lib
RUN cp /app/build/bin/curl /build/bin/
RUN cp /app/build/lib/libcurl.so.4 /build/lib/libcurl.so.4
