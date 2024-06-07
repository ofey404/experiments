import { NextApiRequest, NextApiResponse } from "next";
import Redis from "ioredis";
import { NextRequest, NextResponse } from "next/server";

const redis = new Redis({
  port: 6379,
  host: "localhost",
});

export interface GetParams {
  key: string;
}

export interface GetResponse {
  reply: string;
}

export async function GET(req: NextRequest) {
  const key = req.nextUrl.searchParams.get("key");

  if (!key) {
    return NextResponse.json(
      { message: "Missing key in request" },
      { status: 400 }
    );
  }

  const value = await redis.get(String(key));

  return NextResponse.json({ reply: value }, { status: 200 });
}
