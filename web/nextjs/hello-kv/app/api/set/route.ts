import { NextApiRequest, NextApiResponse } from 'next';
import Redis from 'ioredis';
import { NextRequest, NextResponse } from 'next/server';

const redis = new Redis({
  port: 6379,
  host: 'localhost',
});

export async function POST(req: NextRequest) {
  const body = await req.json()
  const { key, value } = body;
  
  if (!key || !value) {
    return NextResponse.json({ error: 'Missing key or value in request body' }, { status: 400 });
  }
  
  await redis.set(key, value);
  
  return NextResponse.json({ reply: 'OK' }, { status: 200 });
};

