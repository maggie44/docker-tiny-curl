# docker-tiny-curl

Containerised Tiny Curl application for using in your containers.

Size: 324.0K

<b>Example use:</b>

```
FROM ghcr.io/maggie0002/docker-tiny-curl as base

FROM alpine

COPY --from=base /build /usr/local

CMD curl --help
```
