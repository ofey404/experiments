import Redis from "ioredis";

class ServiceContext {
  private static instance: ServiceContext;
  redis: Redis;

  private constructor() {
    this.redis = new Redis({
      port: 6379,
      host: "localhost",
    });
  }

  public static getSingleton(): ServiceContext {
    if (!ServiceContext.instance) {
      ServiceContext.instance = new ServiceContext();
    }
    return ServiceContext.instance;
  }
}

export const svcCtx = ServiceContext.getSingleton();
