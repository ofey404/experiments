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
            key: t.string(),
            value: t.string(),
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

export const schema = builder.toSchema({})
