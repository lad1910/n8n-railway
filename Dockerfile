FROM n8nio/n8n:latest

USER root

# Install minimal Chromium dependencies for Alpine
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Set Chromium path
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install TelePilot (your existing code)
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@latest && \
    find /home/node/.n8n/nodes -name '*.js' -type f | while read file; do \
        if grep -q "this.emit.*=.*" "$file" 2>/dev/null; then \
            sed -i 's/this\.emit\s*=//g' "$file"; \
        fi; \
    done && \
    chown -R node:node /home/node/.n8n

# Install Playwright browsers
RUN npx playwright install chromium

USER node

EXPOSE 5678
