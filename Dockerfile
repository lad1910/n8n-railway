FROM n8nio/n8n:latest

USER root

# Install system dependencies if needed
RUN apk add --no-cache curl

# Install Telepilot globally
RUN npm install -g @telepilotco/n8n-nodes-telepilot

# Fix permissions
RUN chown -R node:node /home/node/.n8n

USER node

# Telepilot debug environment (optional)
ENV DEBUG=tdl,tdl:client,telepilot-cred,telepilot-node
ENV N8N_LOG_LEVEL=debug

# Required for community nodes
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true
ENV EXECUTIONS_PROCESS=main

# Railway-specific
ENV ENABLE_ALPINE_PRIVATE_NETWORKING=true

CMD ["n8n", "start"]
