# ------------------------
# 1. Base image with Node.js + PostgreSQL
# ------------------------
FROM node:16-alpine AS base

WORKDIR /usr/src/app

# Install build dependencies + PostgreSQL
RUN apk add --no-cache bash python3 make g++ postgresql postgresql-contrib postgresql-client

# Initialize PostgreSQL data directory
RUN mkdir -p /var/lib/postgresql/data /run/postgresql && \
    chown -R postgres:postgres /var/lib/postgresql /run/postgresql


# ------------------------
# 2. Install dependencies
# ------------------------
FROM base AS deps

COPY package*.json ./

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
# 4. Production runtime with PostgreSQL
# ------------------------
FROM node:16-alpine AS prod

WORKDIR /usr/src/app

# Install PostgreSQL runtime
RUN apk add --no-cache postgresql postgresql-client

# Copy dependencies + build
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist
COPY package*.json ./

# Set Postgres environment
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=persondb
ENV PGDATA=/var/lib/postgresql/data

# Expose app port + Postgres default port
EXPOSE 4500 5432

# Start both Postgres and the NestJS app
CMD sh -c "pg_ctl -D /var/lib/postgresql/data -l logfile start && node dist/main"
