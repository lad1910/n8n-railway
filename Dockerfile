FROM ubuntu:22.04

USER root

# Install Node.js, npm, and dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install n8n
RUN npm install -g n8n

# Install Playwright with browsers
RUN npx playwright install chromium
RUN npx playwright install-deps chromium

# Install TelePilot
RUN mkdir -p /root/.n8n/nodes && \
    cd /root/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@latest

EXPOSE 5678

CMD ["n8n", "start"]
