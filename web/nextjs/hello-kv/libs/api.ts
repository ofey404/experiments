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
    handleAxiosError(e);
  }
};

export const get = async (params: GetParams) => {
  try {
    const r = await axios.get<GetResponse>("/api/get", {
      params,
    });
    return r.data;
  } catch (e) {
    handleAxiosError(e);
  }
};

function handleAxiosError(e: any) {
  const err = e as AxiosError<AppErrorBody>;
  if (err.response) {
    const { appCode, message } = err.response.data;
    throw new AppError(appCode, message);
  } else {
    throw e; // re-throw the error if it's not one we understand
  }
}
