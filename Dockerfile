# ------------------------
# 1. Base image with Node.js
# ------------------------
FROM node:16-alpine AS base

WORKDIR /usr/src/app

# Install build dependencies
RUN apk add --no-cache bash python3 make g++


# ------------------------
# 2. Install dependencies
# ------------------------
FROM base AS deps

COPY package*.json ./

# Only install dependencies, skip devDeps for production
RUN npm install --legacy-peer-deps


# ------------------------
# 3. Build the NestJS app
# ------------------------
FROM base AS build

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build


# ------------------------
# 4. Production runtime
# ------------------------
FROM node:16-alpine AS prod

WORKDIR /usr/src/app

COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist
COPY package*.json ./

# Expose app port
EXPOSE 4500

CMD ["node", "dist/main"]
