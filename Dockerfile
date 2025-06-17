FROM n8nio/n8n:latest

USER root

# Install curl for debugging
RUN apk add --no-cache curl

# Create nodes directory with proper permissions
RUN mkdir -p /home/node/.n8n/nodes && \
    chown -R node:node /home/node/.n8n

USER node

# Required for community nodes
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true
ENV EXECUTIONS_PROCESS=main
RUN cd ~/.n8n/ && mkdir nodes && cd nodes && npm install @telepilotco/n8n-nodes-telepilot
# Basic n8n configuration
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

CMD ["n8n", "start"]
