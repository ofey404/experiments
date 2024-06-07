import { NextRequest, NextResponse } from "next/server";
import { svcCtx } from "../serviceContext";
import { ErrKeyNotFound, ErrMissingKey } from "@/libs/errors";

export interface GetParams {
  key: string;
}

export interface GetResponse {
  reply: string;
}

export async function GET(req: NextRequest) {
  const key = req.nextUrl.searchParams.get("key");

  if (!key) {
    return ErrMissingKey.toNextResponse(400);
  }

  const value = await svcCtx.redis.get(String(key));
  if (value === null) {
    return ErrKeyNotFound.toNextResponse(400);
  }

  return NextResponse.json({ reply: value }, { status: 200 });
}
