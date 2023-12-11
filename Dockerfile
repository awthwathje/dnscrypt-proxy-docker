FROM debian:bullseye-slim

ARG USER=dnscrypt
ARG GID_UID=65053
ARG LOG_DIR=/var/log/dnscrypt-proxy
ARG CACHE_DIR=/var/cache/dnscrypt-proxy

WORKDIR /app

ADD dnscrypt-proxy.toml /app/dnscrypt-proxy.toml

RUN apt update && \
    apt upgrade --yes && \
    apt install --yes ca-certificates dnscrypt-proxy

RUN groupadd -r ${USER} --gid=${GID_UID} && \
    useradd -r -g ${USER} --uid=${GID_UID} ${USER}

RUN mkdir ${LOG_DIR} && \
    chown ${USER}:${USER} ${LOG_DIR}

RUN mkdir ${CACHE_DIR} && \
    chown ${USER}:${USER} ${CACHE_DIR}

USER ${USER}

EXPOSE 53

CMD [ "dnscrypt-proxy", "-config", "/app/dnscrypt-proxy.toml" ]
