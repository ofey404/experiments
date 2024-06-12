import { NextRequest, NextResponse } from "next/server";
import { AppError, ErrUnknown, validateSchema } from "@/libs/errors";
import { GetLogic } from "./logic";
import Joi from "joi";

export interface GetParams {
  key: string;
}

const schema = Joi.object<GetParams>({
  key: Joi.string().required()
});

export interface GetResponse {
  reply: string;
}

export async function GET(req: NextRequest) {
  try {
    const params: GetParams = {
      key: req.nextUrl.searchParams.get("key") || ""
    };

    validateSchema(schema, params);

    const resp = await new GetLogic().Handle(params);
    return NextResponse.json(resp, { status: 200 });
  } catch (e) {
    if (e instanceof AppError) {
      return e.toNextResponse(400);
    } else {
      // wrap it as AppError
      return ErrUnknown(e).toNextResponse(500);
    }
  }
}
