# Use the official n8n Docker image as the base image
FROM n8nio/n8n

# Set environment variables for basic authentication
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=""
ENV N8N_BASIC_AUTH_PASSWORD=""

# Expose the n8n port
EXPOSE 5678
