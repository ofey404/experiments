import SchemaBuilder from '@pothos/core'
import { db } from '../db/client'
import SimpleObjectsPlugin from '@pothos/plugin-simple-objects'

interface Root<T> {
  Context: T
}

export interface Context {
  db: typeof db
}

const builder = new SchemaBuilder<Root<Context>>({
  plugins: [SimpleObjectsPlugin]
})

builder.queryType({})
builder.mutationType({})

// objects
export const KeyValueObject = builder.simpleObject(
  "KeyValueObject",
  {
    fields: (t) => ({
      key: t.string({
        nullable: false
      }),
      value: t.string({
        nullable: false
      }),
    }),
  }
)

builder.queryField(
  'getKeyValue',
  (t) => t.field({
    type: [KeyValueObject],
    resolve: async (root, args, context) => {
      const keyValue = await context.db.selectFrom('key_value').selectAll().execute()
      return keyValue
    }
  })
)

export const KeyValueInput = builder.inputType('KeyValueInput', {
  fields: (t) => ({
    key: t.string({
      required: true
    }),
    value: t.string({
      required: true
    }),
  })
})

builder.mutationField(
  'createKeyValue',
  (t) => t.field({
    type: KeyValueObject,
    args: {
      input: t.arg({
        type: KeyValueInput,
        required: true,
      })
    },
    resolve: async (root, args, ctx) => {
      return await ctx.db.insertInto('key_value').values({
        key: args.input.key,
        value: args.input.value
      }).returningAll().executeTakeFirstOrThrow()
    }
  })
)

builder.mutationField(
  'updateKeyValue',
  (t) => t.field({
    type: KeyValueObject,
    args: {
      input: t.arg({
        type: KeyValueInput,
        required: true,
      })
    },
    resolve: async (root, args, ctx) => {
      const data = {
        key: args.input.key,
        value: args.input.value
      }

      // A real smart code. Thank you, Francisco Mendes.
      //
      // Optional fields can be handled automatically.
      // https://dev.to/franciscomendes10866/how-to-build-a-type-safe-graphql-api-using-pothos-and-kysely-4ja3
      return await ctx.db.insertInto('key_value').values(data).
        onConflict((oc) => oc.column('key').doUpdateSet(data)).
        returningAll().executeTakeFirstOrThrow()
    }
  })
)

export const schema = builder.toSchema({})
