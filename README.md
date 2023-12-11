[中文文档](README_cn.md)

Convert shadowsocks to http proxy using docker.

# Introduction

For docker image, using `alpine`, the final image is around 16MB.

For shadowsorks client, using `shadowsocks-rust-sslocal`, which could be directly add via `apk add shadowsocks-rust-sslocal` in `alpine`.

The limit is, this `sslocal` only support these encryption methods now: *plain, none, aes-128-gcm, aes-256-gcm, chacha20-ietf-poly1305, 2022-blake3-aes-128-gcm, 2022-blake3-aes-256-gcm, 2022-blake3-chacha20-poly1305*.

For http proxy, using `Privoxy`.

The `Dockerfile` is very simple:

```docker
FROM alpine

RUN apk add shadowsocks-rust-sslocal privoxy

COPY ./data/* /root/

ENTRYPOINT /bin/sh /root/start.sh
```

# How to Run?

Copy the conf files, edit the ss server info.

```bash
cd ./data
cp privoxy.conf.demo privoxy.conf
cp sslocal.conf.demo sslocal.conf
vi privoxy.conf
vi sslocal.conf
```

Build and run the docker.

```bash
docker build -t docker-ss-proxy:v1 .
docker run -id -p 1080:1080 docker-ss-proxy:v1
```

That's it.

BTW, if you want to using the socks proxy, just open the port in `-p`.

# How to Verify?

Using the follow methond to get the ip, verify it's your ss server's ip or not.

```bash
curl -x localhost:1080 https://api64.ipify.org
```