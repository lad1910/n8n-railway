FROM n8nio/n8n:latest

USER root

# Install TelePilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@0.3.0 && \
    chown -R node:node /home/node/.n8n

USER node

EXPOSE 5678
