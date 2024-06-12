import { ErrKeyNotFound } from "@/libs/errors";
import { GetParams, GetResponse } from "./route";
import { CommonLogic } from "../common-logic";

export class GetLogic extends CommonLogic {
  async Handle(req: GetParams): Promise<GetResponse> {
    const value = await this.sc.redis.get(String(req.key));
    if (value === null) {
      throw ErrKeyNotFound;
    }

    return { reply: value } as GetResponse;
  }
}
