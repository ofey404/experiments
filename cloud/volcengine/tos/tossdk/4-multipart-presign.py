# See https://www.volcengine.com/docs/6349/92801
import os
import tos
from tos.utils import SizeAdapter

from client import new_client, BUCKET

client = new_client()

object_key = 'test-sdk/testfile.txt'
file_name = 'testfile.txt'
total_size = os.path.getsize(file_name)
part_size = 5 * 1024 * 1024
try:
    # 初始化上传任务
    # 若需在初始化分片时设置对象的存储类型，可通过storage_class字段设置
    # 若需在初始化分片时设置对象ACL，可通过acl、grant_full_control等字段设置
    multi_result = client.create_multipart_upload(BUCKET,
                                                  object_key,
                                                  acl=tos.ACLType.ACL_Public_Read,
                                                  storage_class=tos.StorageClassType.Storage_Class_Standard)

    upload_id = multi_result.upload_id
    parts = []

    # 上传分片数据
    with open(file_name, 'rb') as f:
        part_number = 1
        offset = 0
        while offset < total_size:
            num_to_upload = min(part_size, total_size - offset)
            out = client.upload_part(BUCKET,
                                     object_key,
                                     upload_id,
                                     part_number,
                                     content=SizeAdapter(f, num_to_upload, init_offset=offset))
            parts.append(out)
            offset += num_to_upload
            part_number += 1

    # 完成分片上传任务
    client.complete_multipart_upload(BUCKET, object_key, upload_id, parts)
except tos.exceptions.TosClientError as e:
    # 操作失败，捕获客户端异常，一般情况为非法请求参数或网络异常
    print('fail with client error, message:{}, cause: {}'.format(e.message, e.cause))
except tos.exceptions.TosServerError as e:
    # 操作失败，捕获服务端异常，可从返回信息中获取详细错误信息
    print('fail with server error, code: {}'.format(e.code))
    # request id 可定位具体问题，强烈建议日志中保存
    print('error with request id: {}'.format(e.request_id))
    print('error with message: {}'.format(e.message))
    print('error with http code: {}'.format(e.status_code))
except Exception as e:
    print('fail with unknown error: {}'.format(e))
