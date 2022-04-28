import 'reflect-metadata';
import { ApolloServer } from 'apollo-server';
import { PrismaClient } from './generated/client';
import { resolvers } from './generated/graphql';
import { buildSchema } from 'type-graphql';

const prisma = new PrismaClient();

// A `main` function so that you can use async/await
async function main() {
  const schema = await buildSchema({
    resolvers,
    validate: false,
  });
  // The ApolloServer constructor requires two parameters: your schema
  // definition and your set of resolvers.
  const server = new ApolloServer({ schema, context: { prisma } });

  // The `listen` method launches a web server.
  const { url } = await server.listen();
  console.log(`🚀  Server ready at ${url}`);
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
