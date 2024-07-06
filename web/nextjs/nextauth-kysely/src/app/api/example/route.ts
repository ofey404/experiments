import { NextRequest, NextResponse } from "next/server";

import { Pool } from 'pg'
import { Kysely, PostgresDialect } from 'kysely';
import { DB } from "@/libs/types/db";

export async function POST(req: NextRequest) {
    const db = new Kysely<DB>({
        dialect: new PostgresDialect({
            pool: new Pool({
                connectionString: process.env.DATABASE_URL,
            })
        }),
    });

    // count key
    const countResult = await db.selectFrom('key_value').select([
        b => b.fn.count("key_value.key").as("total_keys")
    ]).executeTakeFirst()

    await db.insertInto('key_value').values({
        key: `key_${Math.random().toString(36).substring(2, 15)}`,
        value: 'dummy_value'
    }).execute();

    const timestamp = new Date().toISOString();
    await db.destroy();

    return NextResponse.json({ 
        message: `Hello, world! Timestamp: ${timestamp}`, 
        keyValueCount: countResult?.total_keys
    });
}
