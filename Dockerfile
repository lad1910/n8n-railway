FROM n8nio/n8n:latest

# Set working directory
WORKDIR /data

# Install the existing packages (from original repo)
RUN npm install cheerio axios moment

# Create nodes directory and install TelePilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@0.5.2

# Set TelePilot environment variables for debugging
ENV DEBUG=tdl,tdl:client,telepilot-cred,telepilot-node,telepilot-trigger,telepilot-cm
ENV N8N_LOG_LEVEL=debug

# Ensure proper permissions for the node user
RUN chown -R node:node /home/node/.n8n

# Switch back to node user (security best practice)
USER node
