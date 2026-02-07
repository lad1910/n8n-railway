FROM n8nio/n8n:latest

USER root

# Copy image to the correct location
COPY image/followup.png /home/node/.n8n/image/followup.png

RUN mkdir -p /home/node/.n8n/image && \
    chown -R node:node /home/node/.n8n/image && \
    chmod -R 755 /home/node/.n8n/image

USER node

EXPOSE 5678
