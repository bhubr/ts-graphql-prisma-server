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

# 2ème étape -> lancer l'app
# Copier le dist de la 1ère stage vers notre 2ème stage
FROM node:16-alpine

WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn --production --frozen-lockfile

COPY --from=builder /app/dist dist
COPY --from=builder /app/node_modules/.prisma node_modules/.prisma

CMD yarn start