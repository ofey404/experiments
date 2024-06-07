import { ErrMissingKey, ErrMissingVal } from "@/libs/errors";
import { SetRequest, SetResponse } from "./route";
import { svcCtx } from "../serviceContext";

export class SetLogic {
  async Handle(req: SetRequest): Promise<SetResponse> {
    if (!req.key) {
      throw ErrMissingKey;
    }
    if (!req.value) {
      throw ErrMissingVal;
    }

    await svcCtx.redis.set(req.key, req.value);

    return { reply: "OK" };
  }
}
