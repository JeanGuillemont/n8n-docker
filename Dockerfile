FROM node:16-alpine as build-stage

RUN apk add --no-cache ca-certificates libressl
RUN npm install -g n8n@latest

FROM alpine:latest as production-stage

COPY --from=build-stage /usr/local/bin/n8n /usr/local/bin/

ENV TZ="UTC"
ENV DATA_FOLDER=/data

VOLUME /data

EXPOSE 5678

RUN npm install -g n8n@latest

CMD ["n8n"]
