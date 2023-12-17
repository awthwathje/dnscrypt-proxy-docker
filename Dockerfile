FROM alpine

ARG USER=dnscrypt
ARG UID_GID=65053
ARG APP_DIR=/app
ARG CONFIG=dnscrypt-proxy.toml
ARG START_SCRIPT=start.sh
ARG LOG_DIR=/var/log/dnscrypt-proxy
ARG CACHE_DIR=/var/cache/dnscrypt-proxy

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache ca-certificates dnscrypt-proxy

RUN deluser ${USER} && \
    addgroup -g ${UID_GID} ${USER} && \
    adduser -D -G ${USER} -u ${UID_GID} -s /sbin/nologin -h /var/empty ${USER}

RUN chown ${USER}:${USER} ${LOG_DIR} && \
    chown ${USER}:${USER} ${CACHE_DIR}

WORKDIR ${APP_DIR}
RUN chown -R ${USER}:${USER} ${APP_DIR}

ADD ${CONFIG} ./${CONFIG}
ADD ${START_SCRIPT} ./${START_SCRIPT}

RUN chgrp ${USER} ./${START_SCRIPT}
RUN chmod u-x,g+x,o-x ./${START_SCRIPT}

USER ${USER}

EXPOSE 53

CMD ["./start.sh"]