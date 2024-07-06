import PostgresAdapter from "@auth/pg-adapter"
import NextAuth from "next-auth"
import { pool } from "./libs/db/client"
 
export const { handlers, signIn, signOut, auth } = NextAuth({
  // https://authjs.dev/getting-started/adapters/pg
  adapter: PostgresAdapter(pool),
  providers: [],
})