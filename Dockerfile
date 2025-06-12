FROM n8nio/n8n:latest

WORKDIR /data
RUN cd ~/.n8n/ && mkdir -p nodes && cd nodes && npm install @telepilotco/n8n-nodes-telepilot
RUN npm install cheerio axios moment
