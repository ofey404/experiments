import { Pool } from 'pg'
import { DB } from "@/libs/db/types";
import { Kysely, PostgresDialect } from 'kysely';

export const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
})

export const db = new Kysely<DB>({
    dialect: new PostgresDialect({
        pool: pool
    })
})

