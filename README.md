# Node / TypeScript / Apollo Server / Prisma / TypeGraphQL Prisma

## Build Docker image

```
docker build -t gql-node-server:latest .
```

## Run Docker container

```
docker run -it -p 4000:4000 -v $PWD/src:/app/src -v $PWD/prisma:/app/prisma --name gql-server --env DATABASE_URL="file:./dev.db" gql-node-server:latest
```