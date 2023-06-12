FROM node:18-alpine as build
WORKDIR /app

COPY package.json ./
RUN npm install --only=production
COPY . .

FROM alpine:latest  
RUN apk --update --no-cache add \
    ca-certificates \
    libressl \
    shadow \ 
    tzdata

WORKDIR /app
COPY --from=build /app .

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data" \
  PORT=5678

VOLUME ["/data"]
EXPOSE $PORT

HEALTHCHECK CMD curl --fail http://localhost:$PORT/ || exit 1

LABEL name="n8n" \
      version="1.0" \
      description="Node.js app built with Docker"

CMD ["node", "app.js"]

# Set memory limit
ENV MEM_LIMIT=256M

# Set memory + swap limit     
ENV MEM_LIMIT_SWAP=384M
