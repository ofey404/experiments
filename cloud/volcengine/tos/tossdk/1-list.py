from client import new_client, BUCKET

client = new_client()

# list has a upper limit 1000, by default
out = client.list_objects(BUCKET)
for o in out.contents:
    print(o.key)

while out.is_truncated:
    out = client.list_objects(BUCKET, marker=out.next_marker)
    for ob in out.contents:
        print(ob.key)
