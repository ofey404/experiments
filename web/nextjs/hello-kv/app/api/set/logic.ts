import { SetRequest, SetResponse } from "./route";
import { svcCtx } from "../serviceContext";

export class SetLogic {
  async Handle(req: SetRequest): Promise<SetResponse> {
    await svcCtx.redis.set(req.key, req.value);

    return { reply: "OK" };
  }
}
