
使用 Docker 将 shadowsocks 转换为 http 代理。

# 介绍

对于 docker image，使用 `alpine`，最终 image 大小仅 16MB。

对于 shadowsorks 客户端，使用 `shadowsocks-rust-sslocal`，可以直接通过 `apk add shadowsocks-rust-sslocal` 安装。

已知的局限是，这个版本的 `sslocal` 默认仅支持这些加密方式：*plain, none, aes-128-gcm, aes-256-gcm, chacha20-ietf-poly1305, 2022-blake3-aes-128-gcm, 2022-blake3-aes-256-gcm, 2022-blake3-chacha20-poly1305*。

对于 http 代码， 使用 `Privoxy`。

`Dockerfile` 非常简单：

```docker
FROM alpine

RUN apk add shadowsocks-rust-sslocal privoxy

COPY ./data/* /root/

ENTRYPOINT /bin/sh /root/start.sh
```

# 如何运行？

复制配置文件，编辑 ss 服务器信息。

```bash
cd ./data
cp privoxy.conf.demo privoxy.conf
cp sslocal.conf.demo sslocal.conf
vi privoxy.conf
vi sslocal.conf
```

构建并运行 docker：

```bash
docker build -t docker-ss-proxy:v1 .
docker run -id -p 1080:1080 docker-ss-proxy:v1
```

结束。

另外，如果你需要使用 socks 代码，在 docker 中开放相应端口即可。

# 如何验证？

可使用下面的命令行获取 ip，比较和 ss 服务器 ip 是否相同即可。

```bash
curl -x localhost:1080 https://api64.ipify.org
```