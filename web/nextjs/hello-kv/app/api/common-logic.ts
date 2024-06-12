import Redis from "ioredis";

interface ServiceContext {
    redis: Redis;
}

export class CommonLogic {
    sc: ServiceContext;

    constructor() {
        this.sc = {
            redis: new Redis({
                port: 6379,
                host: "localhost",
            })
        }
        this.sc.redis.on('error', (error) => {
            console.error('Redis error: ', error);
            // Throw an Error
            throw new Error('Redis connection error');
        });
    }
}