FROM n8nio/n8n:latest

USER root

# Install TelePilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@latest && \
    find /home/node/.n8n/nodes -name '*.js' -type f | while read file; do \
        if grep -q "this.emit.*=.*" "$file" 2>/dev/null; then \
            sed -i 's/this\.emit\s*=//g' "$file"; \
        fi; \
    done && \
    chown -R node:node /home/node/.n8n

# Copy image to the correct location (with dot: .n8n)
COPY image/followup.png /home/node/.n8n/image/followup.png

# Create directory and set permissions
RUN mkdir -p /home/node/.n8n/image && \
    chown -R node:node /home/node/.n8n/image && \
    chmod -R 755 /home/node/.n8n/image

USER node

EXPOSE 5678
