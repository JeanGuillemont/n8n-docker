# Use the latest node:16-alpine image
FROM node:16-alpine

# Install necessary dependencies
RUN apk --update --no-cache add \
    ca-certificates \
    graphicsmagick \
    libressl \
    shadow \
    tzdata \
  && apk --no-cache add --virtual fonts \
    fontconfig \
    msttcorefonts-installer \
  && update-ms-fonts \
  && fc-cache -f \
  && addgroup -g 1500 n8n \
  && adduser -u 1500 -G n8n -h /data -s /bin/sh -D n8n \
  && apk del fonts \
  && rm -rf /tmp/*

WORKDIR /app

# Install the latest n8n version
RUN apk --update --no-cache add --virtual .build \
    build-base \
    git \
    python3 \
  && npm_config_user=n8n npm install -g n8n \
  && chown -R n8n. /app \
  && apk del .build \
  && rm -rf /root /tmp/* \
  && mkdir /root

USER n8n

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data"

VOLUME [ "/data" ]
EXPOSE 5678

CMD [ "n8n" ]
