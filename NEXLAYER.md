# Nexlayer — stripe-integration

<!-- nexlayer:meta version=1 analyzed=2026-06-30T19:58:14Z repo=https://github.com/Itsamk-ship-it/stripe-integration branch=nexlayer -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
A Next.js application integrating Stripe for payment processing, utilizing the App Router and standalone production builds.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Next.js | framework | 16.2.9 | package.json |
| React | framework | 19.2.4 | package.json |
| Stripe | tool | 22.3.0 | package.json |
| Node.js | language | 22-alpine | Dockerfile |
| TypeScript | language | 5 | package.json |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- app/ — Next.js App Router pages and API routes
- lib/ — Utility functions and shared logic
- public/ — Static assets
- Dockerfile — Multi-stage build for standalone deployment
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- Stripe API (STRIPE_SECRET_KEY, STRIPE_WEBHOOK_SECRET)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Node.js >= 20
- bun (preferred as bun.lock is present)

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
```

### Steps

1. `bun install` — Install dependencies using bun
2. `bun dev` — Start development server on http://localhost:3000

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `NODE_ENV` | `"production"` | plain |
| `app` | `PORT` | `"3000"` | plain |
| `app` | `HOSTNAME` | `"0.0.0.0"` | plain |
| `app` | `STRIPE_SECRET_KEY` | `"${STRIPE_SECRET_KEY}"` | inter-pod |
| `app` | `STRIPE_WEBHOOK_SECRET` | `"${STRIPE_WEBHOOK_SECRET}"` | inter-pod |
| `app` | `NEXT_PUBLIC_APP_URL` | `"<% URL %>"` | plain |

### nexlayer.yaml

```yaml
application:
  name: stripe-integration
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kdnss9re3ack631zmxgpra36/stripe-integration:19f1a210884"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: "production"
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
        STRIPE_SECRET_KEY: "${STRIPE_SECRET_KEY}"
        STRIPE_WEBHOOK_SECRET: "${STRIPE_WEBHOOK_SECRET}"
        NEXT_PUBLIC_APP_URL: "<% URL %>"
```
<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| stripe-web | mirror.gcr.io/library/node:22-alpine | 3000 | web |

### Deployment notes

- The application is deployed as a standalone Node.js server via the runner stage in the Dockerfile.
- No internal database pod is specified in the current repository source; if added, it must follow the <podName>.pod:port convention.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-30T20:05:15Z  
**Live URL:** https://vibrant-wasp-stripe-integration.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: stripe-integration
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kdnss9re3ack631zmxgpra36/stripe-integration:19f1a210884"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: "production"
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
        STRIPE_SECRET_KEY: "${STRIPE_SECRET_KEY}"
        STRIPE_WEBHOOK_SECRET: "${STRIPE_WEBHOOK_SECRET}"
        NEXT_PUBLIC_APP_URL: "<% URL %>"
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-30T20:03:41Z | analyzed | initial repo analysis |
| 2026-06-30T20:05:15Z | success | deployed https://vibrant-wasp-stripe-integration.cloud.nexlayer.ai |
<!-- nexlayer:end -->

