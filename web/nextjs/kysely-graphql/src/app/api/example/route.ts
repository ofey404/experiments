import { schema } from "@/libs/graphql/schema";
import { ApolloServer } from "@apollo/server";
import { startServerAndCreateNextHandler } from "@as-integrations/next";

const server = new ApolloServer({
  schema,
});

const handler = startServerAndCreateNextHandler(server);

export { handler as GET, handler as POST };
