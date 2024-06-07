import Redis from "ioredis";
import { NextRequest, NextResponse } from "next/server";

const redis = new Redis({
  port: 6379,
  host: "localhost",
});

export interface SetRequest {
  key: string;
  value: string;
}

export interface SetResponse {
  reply?: string;
  error?: string;
}

export async function POST(req: NextRequest) {
  const { key, value }: SetRequest = await req.json();

  if (!key || !value) {
    const response: SetResponse = {
      error: "Missing key or value in request body",
    };
    return NextResponse.json(response, { status: 400 });
  }

  await redis.set(key, value);

  const response: SetResponse = { reply: "OK" };
  return NextResponse.json(response, { status: 200 });
}
