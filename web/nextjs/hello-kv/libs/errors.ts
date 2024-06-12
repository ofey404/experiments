import Joi from "joi";
import { NextResponse } from "next/server";

export class AppError extends Error {
  appCode: number;
  rawMessage: string;

  constructor(appCode: number, message: string) {
    super(`AppError(${appCode}): ${message}`); // displays code + message in every built-in places
    this.appCode = appCode;
    this.rawMessage = message;
  }

  toNextResponse(code?: number) {
    return NextResponse.json(
      {
        appCode: this.appCode,
        message: this.rawMessage,
      } as AppErrorBody,
      { status: code ? code : 400 }
    );
  }

  is(e: any): boolean {
    if (e instanceof AppError) {
      return e.appCode === this.appCode;
    }
    return false;
  }

  withMessage(m: string) {
    return new AppError(this.appCode, m);
  }
}

export interface AppErrorBody {
  appCode: number;
  message: string;
}

export function validateSchema(schema: Joi.ObjectSchema, data: any) {
  const { error } = schema.validate(data);
  if (error) {
    throw ErrValidateSchema.withMessage(
      error.details[0].message
    )
  }
}

export const ErrUnknown = (e: any) => {
  try {
    const s = JSON.stringify(e);
    return new AppError(0, s);
  } catch (_) {
    // Ignore errors in stringifying
    return new AppError(0, "error cannot be stringified");
  }
};

export const ErrInternal = new AppError(10000, "internal service error");
export const ErrValidateSchema = new AppError(10001, "schema validate error");
export const ErrKeyNotFound = new AppError(10002, "key not found");
export const ErrMissingKey = new AppError(10003, "missing key in request");
export const ErrMissingVal = new AppError(10004, "missing value in request");
