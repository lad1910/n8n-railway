FROM n8nio/n8n:1.76.1

USER root

# Install TelePilot community node
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@0.5.2 && \
    chown -R node:node /home/node/.n8n

USER node

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
EXPOSE 5678
