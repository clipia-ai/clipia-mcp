FROM node:22.22.1-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev --ignore-scripts \
  && npm cache clean --force

COPY docker-entrypoint.sh /usr/local/bin/clipia-mcp
RUN chmod 0555 /usr/local/bin/clipia-mcp

ENV HOME=/tmp \
  NODE_ENV=production \
  CLIPIA_MCP_URL=https://mcp.clipia.ai/mcp

USER node

ENTRYPOINT ["clipia-mcp"]
