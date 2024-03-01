import Redis from 'ioredis';
import { NextRequest, NextResponse } from 'next/server';
import { SetRequest, SetResponse } from './types';

const redis = new Redis({
  port: 6379,
  host: 'localhost',
});

export async function POST(req: NextRequest) {
  const { key, value }: SetRequest = await req.json()
  
  if (!key || !value) {
    const response: SetResponse = { error: 'Missing key or value in request body' };
    return NextResponse.json(response, { status: 400 });
  }
  
  await redis.set(key, value);
  
  const response: SetResponse = { reply: 'OK' };
  return NextResponse.json(response, { status: 200 });
};

