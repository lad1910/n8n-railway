FROM n8nio/n8n:latest

WORKDIR /data

# Already has these packages
RUN npm install -g axios cheerio moment

# ADD THIS SECTION FOR TELEPILOT
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@0.3.0

EXPOSE 5678

CMD ["n8n", "start"]
