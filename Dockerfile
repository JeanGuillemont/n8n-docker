FROM node:16-alpine

RUN apk --update --no-cache add \
    ca-certificates \
    libressl \  
    shadow \
    tzdata

RUN npm install -g n8n

RUN addgroup -g 1500 n8n \
    && adduser -u 1500 -G n8n -h /data -s /bin/sh -D n8n

WORKDIR /app
RUN chown -R n8n. /app

USER n8n  

ENV TZ="UTC" \
    DATA_FOLDER="/data" \  
    N8N_BASIC_AUTH_ACTIVE=true \
    N8N_BASIC_AUTH_USER="" \
    N8N_BASIC_AUTH_PASSWORD=""

VOLUME ["/data"]     
EXPOSE 5678

ENTRYPOINT ["node", "/app/node_modules/n8n/bin/n8n"]
