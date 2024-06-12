import { NextRequest, NextResponse } from "next/server";
import { AppError, ErrUnknown, ErrValidateSchema, validateSchema } from "@/libs/errors";
import { SetLogic } from "./logic";
import Joi from "joi";

export interface SetRequest {
  key: string;
  value: string;
}
const schema = Joi.object({
  key: Joi.string().required(),
  value: Joi.string().required(),
});

export interface SetResponse {
  reply?: string;
}

export async function POST(req: NextRequest) {
  try {
    const data: SetRequest = await req.json();
    validateSchema(schema, data);

    const resp = await new SetLogic().Handle(data);
    return NextResponse.json(resp, { status: 200 });
  } catch (e) {
    if (e instanceof AppError) {
      return e.toNextResponse();
    } else {
      // wrap it as AppError
      return ErrUnknown(e).toNextResponse(500);
    }
  }
}
