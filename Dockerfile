FROM node:16

RUN apk --update --no-cache add \
    ca-certificates \
    libressl \
    shadow \
    tzdata

RUN npm_config_user=n8n npm install -g n8n --no-cache

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data"

EXPOSE 5678

VOLUME [ "/data" ]

ENTRYPOINT [ "node", "/usr/local/bin/n8n" ]
CMD ["n8n"]
