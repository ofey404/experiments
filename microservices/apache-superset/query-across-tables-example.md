# query across tables

In config file:

```python
FEATURE_FLAGS = {
    "ENABLE_SUPERSET_META_DB": True,
}
```

Enable superset meta database, the URL could be a placeholder `superset://`:

Cross table join example:

```sql
SELECT * FROM "Database1.public.table_1" AS db1
JOIN "Database2.public.table_1" AS db2
ON db1.id = db2.user_id
```
