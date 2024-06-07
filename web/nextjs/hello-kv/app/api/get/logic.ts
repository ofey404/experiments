import { ErrKeyNotFound } from "@/libs/errors";
import { svcCtx } from "../serviceContext";
import { GetParams, GetResponse } from "./route";

export class GetLogic {
  async Handle(req: GetParams): Promise<GetResponse> {
    const value = await svcCtx.redis.get(String(req.key));
    if (value === null) {
      throw ErrKeyNotFound;
    }

    return { reply: value } as GetResponse;
  }
}
