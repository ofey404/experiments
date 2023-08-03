import os 
import tos

try:
    import crcmod._crcfunext
except ImportError:
    raise Exception("TOS requires the crcmod C extension, or the slow python-native checksum would severely hurt upload performance")

# Accesskey和Secretkey可在用户火山引擎账号中查找。
ak = os.environ["VOLCENGINE_ACCESS_KEY"]
sk = os.environ["VOLCENGINE_SECRET_KEY"]
bucket = os.environ["VOLCENGINE_TEST_BUCKET"]

# your endpoint 和 your region 填写Bucket 所在区域对应的Endpoint。# 以华北2(北京)为例，your endpoint 填写 tos-cn-beijing.volces.com，your region 填写 cn-beijing。 
endpoint = "tos-cn-beijing.volces.com"
region = "cn-beijing"

client = tos.TosClientV2(ak, sk, endpoint, region)

# list has a upper limit 1000, by default
out = client.list_objects(bucket)
for o in out.contents:
    print(o.key)

while out.is_truncated:
    out = client.list_objects(bucket, marker=out.next_marker)
    for ob in out.contents:
        print(ob.key)
