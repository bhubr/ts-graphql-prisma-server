# Node / TypeScript / Apollo Server / Prisma / TypeGraphQL Prisma

## Build Docker image

Before renaming developmenet `Dockerfile` to `Dockerfile.dev`:

```
docker build -t gql-node-server:latest .
```

After renaming developmenet `Dockerfile` to `Dockerfile.dev`:

```
docker build -t gql-node-server:latest -f Dockerfile.dev .
```

## Run Docker container

```
docker run -it -p 4000:4000 -v $PWD/src:/app/src -v $PWD/prisma:/app/prisma --name gql-server --env DATABASE_URL="file:./dev.db" gql-node-server:latest
```