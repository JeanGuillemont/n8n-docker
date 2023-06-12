FROM node:16   

WORKDIR /app

COPY package*.json ./        
RUN npm install --only=production

COPY . .

ENV TZ="UTC"        
ENV DATA_FOLDER=/data

VOLUME $DATA_FOLDER

EXPOSE 5678

CMD ["n8n"]        

HEALTHCHECK CMD curl --fail http://localhost:5678/health || exit 1
