import { z } from "zod";

import { createTRPCRouter, publicProcedure } from "@/server/api/trpc";

export interface User {
  id: number;
  name: string;
  username: string;
  email: string;
  address: {
    street: string;
    suite: string;
    city: string;
    zipcode: string;
    geo: {
      lat: string;
      lng: string;
    };
  };
  phone: string;
  website: string;
  company: {
    name: string;
    catchPhrase: string;
    bs: string;
  };
}

// Mocked DB
const users: User[] = [
  {
    id: 1,
    name: "Leanne Graham",
    username: "Bret",
    email: "Sincere@april.biz",
    address: {
      street: "Kulas Light",
      suite: "Apt. 556",
      city: "Gwenborough",
      zipcode: "92998-3874",
      geo: {
        lat: "-37.3159",
        lng: "81.1496"
      }
    },
    phone: "1-770-736-8031 x56442",
    website: "hildegard.org",
    company: {
      name: "Romaguera-Crona",
      catchPhrase: "Multi-layered client-server neural-net",
      bs: "harness real-time e-markets"
    }
  },
  {
    id: 2,
    name: "Ervin Howell",
    username: "Antonette",
    email: "Shanna@melissa.tv",
    address: {
      street: "Victor Plains",
      suite: "Suite 879",
      city: "Wisokyburgh",
      zipcode: "90566-7771",
      geo: {
        lat: "-43.9509",
        lng: "-34.4618",
      }
    },
    phone: "010-692-6593 x09125",
    website: "anastasia.net",
    company: {
      name: "Deckow-Crist",
      catchPhrase: "Proactive didactic contingency",
      bs: "synergize scalable supply-chains",
    },
  },
];

export const userRouter = createTRPCRouter({
  create: publicProcedure
    .input(z.object({
      name: z.string().min(1),
      username: z.string().min(1),
      email: z.string().email(),
      address: z.object({
        street: z.string(),
        suite: z.string(),
        city: z.string(),
        zipcode: z.string(),
        geo: z.object({
          lat: z.string(),
          lng: z.string(),
        }),
      }),
      phone: z.string(),
      website: z.string(),
      company: z.object({
        name: z.string(),
        catchPhrase: z.string(),
        bs: z.string(),
      }),
    }))
    .mutation(async ({ input }) => {
      const user: User = {
        id: users.length + 1,
        ...input,
      };
      users.push(user);
      return user;
    }),

  get: publicProcedure
    .input(z.object({ id: z.number() }))
    .query(({ input }) => {
      const user = users.find(u => u.id === input.id);
      if (!user) throw new Error("User not found");
      return user;
    }),

  update: publicProcedure
    .input(z.object({
      id: z.number(),
      name: z.string().min(1).optional(),
      username: z.string().min(1).optional(),
      email: z.string().email().optional(),
      address: z.object({
        street: z.string(),
        suite: z.string(),
        city: z.string(),
        zipcode: z.string(),
        geo: z.object({
          lat: z.string(),
          lng: z.string(),
        }),
      }).optional(),
      phone: z.string().optional(),
      website: z.string().optional(),
      company: z.object({
        name: z.string(),
        catchPhrase: z.string(),
        bs: z.string(),
      }).optional(),
    }))
    .mutation(({ input }) => {
      const index = users.findIndex(u => u.id === input.id);
      if (index === -1) throw new Error("User not found");
      users[index] = { ...users[index], ...input } as User;
      return users[index];
    }),

  delete: publicProcedure
    .input(z.object({ id: z.number() }))
    .mutation(({ input }) => {
      const index = users.findIndex(u => u.id === input.id);
      if (index === -1) throw new Error("User not found");
      const [deletedUser] = users.splice(index, 1);
      return deletedUser;
    }),
});