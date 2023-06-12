FROM node:18-alpine

WORKDIR /app
RUN apk add --no-cache nodejs npm ca-certificates libressl

RUN npm install -g npm@latest

RUN npm install -g n8n@latest       

ENV TZ="UTC"        
ENV DATA_FOLDER=/data

VOLUME $DATA_FOLDER

EXPOSE 5678

CMD ["n8n"]        
