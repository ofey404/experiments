# go-zero-postgres-flyway

This example service supports database versioning, seamless migration, and service side schema validation.

More to see [commands.sh](./commands.sh)

```plain text
      │
  API │
┌─────▼────────────────────┐
│ Service Logic            │
│ (Get/Set in internal/)   │
└─────┬────────────────────┘
      ├───────── OR ───────────────────────┐
┌─────▼────────────────────┐     ┌─────────▼────────────────┐
│ Model V1                 │     │ Model V2                 │
│ (model/modelv1/)         │     │ (model/modelv2/)         │
└─────┬────────────────────┘     └─────────┬────────────────┘
┌─────▼────────────────────┐     ┌─────────▼────────────────┐
│ Schema V1                │     │ Schema V2                │
│ (model/db/schema/V1.sql) │     │ (model/db/schema/V2.sql) │
└─────▲───────────────────┬┘     └────▲─────────────────────┘
      │ Init db           │ Flyway    │
      │                   │ migration │
┌─────┴────────────────┬──▼───────────┴────────┐
│ Migration 0->1       │ Migration 1->2        │
│ V1__create_schema.sql│ V2_value_not_null.sql │
└──────────────────────┴───────────────────────┘
```
