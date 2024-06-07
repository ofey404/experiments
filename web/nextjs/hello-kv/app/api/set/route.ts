import { NextRequest, NextResponse } from "next/server";
import { AppError, ErrUnknown, ErrValidateSchema } from "@/libs/errors";
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
  const data: SetRequest = await req.json();
  const { error } = schema.validate(data);
  if (error) {
    return ErrValidateSchema.withMessage(
      error.details[0].message
    ).toNextResponse();
  }

  const logic = new SetLogic();

  try {
    const resp = await logic.Handle(data);
    return NextResponse.json(resp, { status: 200 });
  } catch (e) {
    if (e instanceof AppError) {
      return e.toNextResponse();
    } else {
      return ErrUnknown(e).toNextResponse(500);
    }
  }
}
