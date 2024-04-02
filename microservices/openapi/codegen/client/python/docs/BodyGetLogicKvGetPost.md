# BodyGetLogicKvGetPost


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**key** | **str** | The key to get the value for | 
**common_args** | [**CommonArgs**](CommonArgs.md) | Common arguments for the request | 

## Example

```python
from hello_kv_client.models.body_get_logic_kv_get_post import BodyGetLogicKvGetPost

# TODO update the JSON string below
json = "{}"
# create an instance of BodyGetLogicKvGetPost from a JSON string
body_get_logic_kv_get_post_instance = BodyGetLogicKvGetPost.from_json(json)
# print the JSON string representation of the object
print(BodyGetLogicKvGetPost.to_json())

# convert the object into a dict
body_get_logic_kv_get_post_dict = body_get_logic_kv_get_post_instance.to_dict()
# create an instance of BodyGetLogicKvGetPost from a dict
body_get_logic_kv_get_post_form_dict = body_get_logic_kv_get_post.from_dict(body_get_logic_kv_get_post_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


