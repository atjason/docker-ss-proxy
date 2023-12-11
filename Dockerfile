FROM alpine

RUN apk add shadowsocks-rust-sslocal privoxy

COPY ./data/* /root/

ENTRYPOINT /bin/sh /root/start.sh
