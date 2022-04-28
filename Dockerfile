FROM node:16-alpine

WORKDIR /app

COPY package.json .
RUN yarn

COPY tsconfig.json .
COPY src src
COPY prisma prisma

RUN npx prisma generate
RUN yarn build

RUN rm -rf node_modules
RUN yarn --production

CMD yarn start
