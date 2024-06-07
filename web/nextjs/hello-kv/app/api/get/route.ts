import { NextRequest, NextResponse } from "next/server";
import { AppError, ErrMissingKey, ErrUnknown } from "@/libs/errors";
import { GetLogic } from "./logic";

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

  const logic = new GetLogic();
  try {
    const resp = await logic.Handle({ key });
    return NextResponse.json(resp, { status: 200 });
  } catch (e) {
    if (e instanceof AppError) {
      return e.toNextResponse(400);
    } else {
      return ErrUnknown(e).toNextResponse(500);
    }
  }
}
