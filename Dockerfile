FROM ubuntu:14.04

RUN apt-get update

RUN apt-get install -y nfs-kernel-server python-setuptools curl vim

RUN easy_install supervisor && \
    curl -L https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 > /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd && \
    mkdir -p /exports

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY conf/nfs-kernel-server.toml /etc/confd/conf.d/nfs-kernel-server.toml
COPY conf/nfs-kernel-server.tmpl /etc/confd/templates/nfs-kernel-server.tmpl

ENV RPC_BIND_OPTS="-f"

EXPOSE 111/udp 2049/tcp

ENTRYPOINT ["docker-entrypoint.sh"]
