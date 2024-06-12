"use client";

import { GetParams, GetResponse } from "@/app/api/get/route";
import { SetRequest, SetResponse } from "@/app/api/set/route";
import axios, { AxiosError, AxiosResponse } from "axios";
import { AppError, AppErrorBody } from "./errors";

export const set = async (body: SetRequest) => {
  try {
    const r = await axios.post<SetResponse>("/api/set", body);
    return r.data;
  } catch (e) {
    handleApiError(e);
  }
};

export const get = async (params: GetParams) => {
  try {
    const r = await axios.get<GetResponse>("/api/get", {
      params,
    });
    return r.data;
  } catch (e) {
    handleApiError(e);
  }
};

function handleApiError(e: any) {
  const err = e as AxiosError<AppErrorBody>;
  if (err.response) {
    const { appCode, message } = err.response.data;
    throw new AppError(appCode, message);
  } else {
    throw e;
  }
}
