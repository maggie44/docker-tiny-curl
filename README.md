# docker-tiny-curl

Containerised Tiny Curl application for using in your containers. Optimised for simple API endpoint requests.

See https://curl.se/tiny/ for more details on Tiny Curl.

Size: 312.0K

<b>Example use:</b>

```
FROM ghcr.io/maggie0002/tiny-curl as tiny-curl

FROM alpine

COPY --from=tiny-curl /build /usr/local

CMD ["curl", "--help"]
```
