FROM n8nio/n8n:latest

USER root

# Install curl for debugging and setup
RUN apk add --no-cache curl

# Create nodes directory with proper permissions
RUN mkdir -p /home/node/.n8n/nodes && \
    chown -R node:node /home/node/.n8n

USER node

# Required for community nodes
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true
ENV EXECUTIONS_PROCESS=main

# Railway-specific
ENV ENABLE_ALPINE_PRIVATE_NETWORKING=true

# Set proxy environment variables (add your proxy here)
ENV HTTP_PROXY=socks5://user107343:crhevm@185.159.84.163:2839
ENV HTTPS_PROXY=socks5://user107343:crhevm@185.159.84.163:2839
ENV ALL_PROXY=socks5://user107343:crhevm@185.159.84.163:2839

CMD ["n8n", "start"]
