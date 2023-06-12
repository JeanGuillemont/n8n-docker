# Use Node.js LTS version as the base image
FROM node:lts-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy source files 
COPY . .

# Set environment variables
ENV TZ="UTC"
ENV NODE_ENV="production"

# Expose port 
EXPOSE 3000

# Set memory limit
ENV MEM_LIMIT=256M
ENV MEM_LIMIT_SWAP=384M

# Healthcheck
HEALTHCHECK CMD npm test

# Run the app
CMD ["npm", "start"]
