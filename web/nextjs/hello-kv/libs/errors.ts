import { NextResponse } from "next/server";

export class AppError extends Error {
  appCode: number;

  constructor(appCode: number, message: string) {
    super(message);
    this.appCode = appCode;
  }

  toNextResponse(code: number) {
    return NextResponse.json(
      {
        appCode: this.appCode,
        message: this.message,
      } as AppErrorBody,
      { status: code }
    );
  }

  is(e: any): boolean {
    if (e instanceof AppError) {
      return e.appCode === this.appCode;
    }
    return false;
  }

  toString(): string {
    return `AppError(${this.appCode}): ${this.message}`;
  }
}

export interface AppErrorBody {
  appCode: number;
  message: string;
}

export const ErrInternal = new AppError(10000, "internal service error");
export const ErrKeyNotFound = new AppError(10001, "key not found");
export const ErrMissingKey = new AppError(10002, "missing key in request");
export const ErrMissingVal = new AppError(10003, "missing value in request");
