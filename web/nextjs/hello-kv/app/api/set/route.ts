import { NextRequest, NextResponse } from "next/server";
import { svcCtx } from "../serviceContext";
import {
  AppError,
  ErrInternal,
  ErrMissingKey,
  ErrMissingVal,
  ErrUnknown,
} from "@/libs/errors";
import { SetLogic } from "./logic";

export interface SetRequest {
  key: string;
  value: string;
}

export interface SetResponse {
  reply?: string;
}

export async function POST(req: NextRequest) {
  const data: SetRequest = await req.json();
  const logic = new SetLogic();

  try {
    const resp = await logic.Handle(data);
    return NextResponse.json(resp, { status: 200 });
  } catch (e) {
    if (e instanceof AppError) {
      return e.toNextResponse(400);
    } else {
      return ErrUnknown(e).toNextResponse(500);
    }
  }
}
