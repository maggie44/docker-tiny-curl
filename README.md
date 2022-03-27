# docker-tiny-curl

Containerised Tiny Curl application for using in your containers. Optimised for simple API endpoint requests.

See https://curl.se/tiny/ for more details on Tiny Curl.

Without SSL: 282.0K

With WolfSSL: 899.0K

<b>Example use without SSL support (smaller, but cannot use `https`):</b>

```
FROM ghcr.io/maggie0002/tiny-curl as tiny-curl

FROM alpine

COPY --from=tiny-curl / /usr/local

CMD ["curl", "--help"]
```

<b>Example use with SSL support:</b>

```
FROM ghcr.io/maggie0002/tiny-curl-ssl as tiny-curl

FROM alpine

COPY --from=tiny-curl / /usr/local

CMD ["curl", "--help"]
```
