FROM n8nio/n8n:latest

USER root

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

# ===================================================================
# ADD IMAGE SUPPORT - NEW SECTION
# ===================================================================

# Copy the follow-up image into the container
COPY image/followup.png /home/node/.n8n/image/followup.png

# Create image directory and set permissions
RUN mkdir -p /home/node/.n8n/image && \
    chown -R node:node /home/node/.n8n/image && \
    chmod -R 755 /home/node/.n8n/image

# ===================================================================

USER node

EXPOSE 5678
