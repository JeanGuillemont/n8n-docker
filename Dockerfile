FROM node:20-alpine
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER
ARG N8N_ENCRYPTION_KEY
ARG PGSSLROOTCERT

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

ENV TZ="UTC"
ENV NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" 
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD
ENV N8N_ENCRYPTION_KEY=$N8N_ENCRYPTION_KEY
ENV PGSSLROOTCERT=$PGSSLROOTCERT

EXPOSE 5678

HEALTHCHECK --interval=5s --timeout=3s \
  CMD n8n --info || exit 1

VOLUME [ "/data" ]

CMD [ "n8n", "start" ]
