FROM alpine:3.15 as build

RUN apk add autoconf automake build-base m4 perl --no-cache

WORKDIR /app

COPY tiny-curl/tiny-curl-7.79.1.tar.gz/ .
RUN tar -xf * --strip-components=1

COPY config/config.sh .
RUN sh config.sh
RUN make
RUN make install

RUN mkdir -p /build/bin /build/lib
RUN cp /app/build/bin/curl /build/bin/
RUN cp /app/build/lib/libcurl.so.4 /build/lib/libcurl.so.4

FROM busybox

COPY --from=build /build /build
