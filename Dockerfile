FROM node:18-alpine

RUN apk --update --no-cache add \
    ca-certificates \
    libressl \
    shadow \
    tzdata

WORKDIR /app  
RUN npm config set unsafe-perm true \
  && npm_config_user=n8n npm install n8n

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data"

VOLUME [ "/data" ]
EXPOSE 5678

ENTRYPOINT [ "node", "/app/node_modules/n8n/bin/n8n" ]
