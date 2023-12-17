FROM alpine

ARG USER=dnscrypt
ARG APP_DIR=/app
ARG CONFIG=dnscrypt-proxy.toml
ARG START_SCRIPT=start.sh

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache ca-certificates dnscrypt-proxy

WORKDIR ${APP_DIR}
RUN chown -R ${USER}:${USER} ${APP_DIR}

ADD ${CONFIG} ./${CONFIG}
ADD ${START_SCRIPT} ./${START_SCRIPT}

RUN chgrp ${USER} ./${START_SCRIPT}
RUN chmod u-x,g+x,o-x ./${START_SCRIPT}

USER ${USER}

EXPOSE 53

CMD ["./start.sh"]
