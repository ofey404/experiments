'use client'
import { DataProvider } from "react-admin";
import { api } from "@/trpc/react";
import { useState } from "react";
import { User } from "@/server/api/routers/user";

export function useDataProvider(): DataProvider {
  const utils = api.useUtils();

  const updateUser = api.user.update.useMutation({
    onSuccess: async () => {
      await utils.user.invalidate();
    },
  });

  return {
    getList: async (resource, params) => {
      if (resource !== 'users') throw new Error('Only users resource is supported');
      let cursor = 0
      let limit = 10
      if (params.pagination) {
        const { page, perPage } = params.pagination;
        cursor = (page - 1) * perPage;
        limit = perPage;
      }

      const users = await utils.user.list.fetch({ cursor, limit });
      return {
        data: users,
        total: users.length + cursor, // This is an approximation, as we don't have a total count
      };
    },

    getOne: async (resource, params) => {
      if (resource !== 'users') throw new Error('Only users resource is supported');
      const user = await utils.user.get.fetch({ id: Number(params.id) });
      return { data: user };
    },

    getMany: async (resource, params) => {
      if (resource !== 'users') throw new Error('Only users resource is supported');
      const users = await Promise.all(params.ids.map(id => utils.user.get.fetch({ id: Number(id) })));
      return { data: users };
    },

    getManyReference: async (resource, params) => {
      return {
        data: [],
        total: 0,
      };
    },
    update: async (resource, params) => {
      if (resource !== 'users') throw new Error('Only users resource is supported');
      const updatedUser = await updateUser.mutateAsync({
        id: Number(params.id),
        ...params.data,
      });
      return { data: updatedUser };
    },

    updateMany: async (resource, params) => {
      return { data: [] };
    },

    create: async (resource, params) => {
      return { data: [] };
    },

    delete: async (resource, params) => {
      return { data: [] };
    },

    deleteMany: async (resource, params) => {
      return { data: [] };
    },
  } as DataProvider;
}