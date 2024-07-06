import { NextRequest, NextResponse } from "next/server";

import { auth } from "@/auth";
import { db } from "@/libs/db/client";

export const POST = auth(async function POST(req) {
    if (!req.auth) {
        return NextResponse.json({ message: "Not authenticated" }, { status: 401 })
    }

    // count key
    const countResult = await db.selectFrom('key_value').select([
        b => b.fn.count("key_value.key").as("total_keys")
    ]).executeTakeFirst()

    // mimic a insertion
    await db.insertInto('key_value').values({
        key: `key_${Math.random().toString(36).substring(2, 15)}`,
        value: 'dummy_value'
    }).execute();

    const timestamp = new Date().toISOString();

    return NextResponse.json({
        message: `Hello, world! Timestamp: ${timestamp}`,
        keyValueCount: countResult?.total_keys
    });
})
