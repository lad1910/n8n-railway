FROM n8nio/n8n:latest

WORKDIR /data

# Skip the npm packages for now - they're not critical
# n8n can access them through NODE_FUNCTION_ALLOW_EXTERNAL anyway

# Just install TelePilot
USER root
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@0.3.0 && \
    chown -R node:node /home/node/.n8n

USER node

EXPOSE 5678

CMD ["n8n", "start"]
