import { CommonLogic } from "../common-logic";
import { SetRequest, SetResponse } from "./route";

export class SetLogic extends CommonLogic {
  async Handle(req: SetRequest): Promise<SetResponse> {
    await this.sc.redis.set(req.key, req.value);

    return { reply: "OK" };
  }
}
