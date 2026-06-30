# Multi-stage build for a Next.js app using `output: "standalone"`.

# 1. Install ALL dependencies (incl. devDeps — needed to run `next build`).
FROM mirror.gcr.io/library/node:22-alpine AS deps
WORKDIR /app
RUN apk add --no-cache python3 make g++
COPY package.json ./
RUN npm install

# 2. Build the production output. This is the step the old Dockerfile was
#    missing: `next start` requires a build, and `output: "standalone"` emits a
#    self-contained server at .next/standalone/server.js.
FROM mirror.gcr.io/library/node:22-alpine AS builder
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# 3. Minimal runtime image — only the standalone server + static assets.
FROM mirror.gcr.io/library/node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000
ENV HOSTNAME=0.0.0.0
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
USER nextjs
EXPOSE 3000
CMD ["node", "server.js"]
