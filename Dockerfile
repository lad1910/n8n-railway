FROM n8nio/n8n:latest

USER root

# Install Chromium and dependencies for Playwright
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    yarn \
    # Additional libraries needed for Chromium
    libx11 \
    libxcomposite \
    libxcursor \
    libxdamage \
    libxext \
    libxfixes \
    libxi \
    libxrandr \
    libxrender \
    libxss \
    libxtst \
    libasound2 \
    libatk-1.0-0 \
    libatk-bridge-2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgdk-pixbuf \
    libglib-2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libxkbcommon

# Set Chromium path for Playwright
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    PLAYWRIGHT_BROWSERS_PATH=/home/node/.cache/ms-playwright

# Install latest TelePilot version and patch emit override issues
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@latest && \
    find /home/node/.n8n/nodes -name '*.js' -type f | while read file; do \
        if grep -q "this.emit.*=.*" "$file" 2>/dev/null; then \
            sed -i 's/this\.emit\s*=//g' "$file"; \
        fi; \
    done && \
    chown -R node:node /home/node/.n8n

# Install Playwright and Chromium browser
RUN npm install -g playwright && \
    npx playwright install chromium && \
    npx playwright install-deps chromium

# Fix permissions
RUN chown -R node:node /home/node

USER node

EXPOSE 5678
