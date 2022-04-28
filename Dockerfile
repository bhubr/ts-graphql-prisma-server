# 1ere étape (stage) -> build
FROM node:16-alpine AS builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN yarn

COPY tsconfig.json .
COPY src src
COPY prisma prisma

RUN yarn prisma generate
RUN yarn tsc

RUN rm -rf node_modules
RUN yarn --production --frozen-lockfile

# 2ème étape -> installer les deps de PROD
# Copier le dist de la 1ère stage vers notre 2ème stage
# FROM node:16-alpine AS installer

# WORKDIR /app
# COPY package.json .
# COPY yarn.lock .
# RUN yarn --production --frozen-lockfile

# # COPY --from=builder /app/dist dist
# COPY --from=builder /app/node_modules/.prisma node_modules/.prisma

# 3ème étape -> lancer l'app
FROM node:16-alpine

WORKDIR /app
COPY package.json .

COPY --from=builder /app/dist dist
COPY --from=builder /app/node_modules node_modules

CMD yarn start
