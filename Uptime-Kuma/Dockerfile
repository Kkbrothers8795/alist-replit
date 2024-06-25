ARG BASE_IMAGE=louislam/uptime-kuma:base2
############################################

FROM louislam/uptime-kuma:builder-go AS build_healthcheck

############################################
# Build in Node.js
############################################
FROM $BASE_IMAGE AS build
USER node
WORKDIR /app

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
COPY --chown=node:node .npmrc .npmrc
COPY --chown=node:node package.json package.json
COPY --chown=node:node package-lock.json package-lock.json
RUN npm ci --omit=dev
COPY . .
COPY --chown=node:node --from=build_healthcheck /app/extra/healthcheck /app/extra/healthcheck
RUN mkdir ./data

############################################
# ⭐ Main Image
############################################
FROM $BASE_IMAGE AS release
USER node
WORKDIR /app

LABEL org.opencontainers.image.source="https://github.com/louislam/uptime-kuma"

ENV UPTIME_KUMA_IS_CONTAINER=1

# Copy app files from build layer
COPY --chown=node:node --from=build /app /app

EXPOSE 3001
HEALTHCHECK --interval=60s --timeout=30s --start-period=180s --retries=5 CMD extra/healthcheck
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["node", "server/server.js"]
