FROM node:16-alpine

WORKDIR /app

COPY package.json .
RUN yarn

COPY tsconfig.json .
COPY prisma prisma
COPY src src

CMD yarn dev
