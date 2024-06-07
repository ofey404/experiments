import { NextRequest, NextResponse } from "next/server";
import { svcCtx } from "../serviceContext";
import { ErrMissingKey, ErrMissingVal } from "@/libs/errors";

export interface SetRequest {
  key: string;
  value: string;
}

export interface SetResponse {
  reply?: string;
}

export async function POST(req: NextRequest) {
  const { key, value }: SetRequest = await req.json();

  if (!key) {
    return ErrMissingKey.toNextResponse(400);
  }
  if (!value) {
    return ErrMissingVal.toNextResponse(400);
  }

  await svcCtx.redis.set(key, value);

  const response: SetResponse = { reply: "OK" };
  return NextResponse.json(response, { status: 200 });
}
