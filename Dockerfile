FROM n8nio/n8n:latest

USER root

# Install TelePilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot@0.3.0

# Create a patch file to fix TelePilot
RUN cat > /tmp/fix-telepilot.sh << 'EOF'
#!/bin/sh
# Find and patch TelePilot files to remove emit override
find /home/node/.n8n/nodes -name "*.js" -type f | while read file; do
  if grep -q "this.emit.*=" "$file" 2>/dev/null; then
    sed -i 's/this\.emit\s*=/\/\/ this.emit =/g' "$file"
    echo "Patched: $file"
  fi
done
EOF

# Run the patch
RUN chmod +x /tmp/fix-telepilot.sh && /tmp/fix-telepilot.sh

# Fix permissions
RUN chown -R node:node /home/node/.n8n

USER node

EXPOSE 5678
