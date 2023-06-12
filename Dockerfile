FROM node:16-alpine

RUN apk --update --no-cache add \
    ca-certificates \
    libressl \
    shadow \
    tzdata

WORKDIR /app

RUN npm_config_user=n8n npm install -g n8n --no-cache

RUN addgroup -g 1500 n8n \
  && adduser -u 1500 -G n8n -h /data -s /bin/sh -D n8n

USER n8n

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data"

EXPOSE 5678

VOLUME [ "/data" ]

ENTRYPOINT [ "node", "/usr/local/bin/n8n" ]
CMD ["n8n", "-p", 5678]
