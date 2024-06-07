import { NextResponse } from "next/server";

export class AppError extends Error {
  appCode: number;

  constructor(appCode: number, message: string) {
    super(message);
    this.appCode = appCode;
  }

  toNextResponse(code?: number) {
    return NextResponse.json(
      {
        appCode: this.appCode,
        message: this.message,
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

  toString(): string {
    return `AppError(${this.appCode}): ${this.message}`;
  }
}

export interface AppErrorBody {
  appCode: number;
  message: string;
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
