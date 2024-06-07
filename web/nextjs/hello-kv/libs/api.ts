'use client'

import { GetParams, GetResponse } from '@/app/api/get/route';
import { SetRequest, SetResponse } from '@/app/api/set/route';
import axios from 'axios';

export const set = async (body: SetRequest) => {
  const r = await axios.post<SetResponse>("/api/set", body);
  return r.data;
};

export const get = async (params: GetParams) => {
    const r = await axios.get<GetResponse>("/api/get", {
        params
    })
    return r.data
}