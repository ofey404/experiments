# BodySetLogicKvSetPost


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**key** | **str** | The key to set the value for | 
**value** | **str** | The value to set | 
**common_args** | [**CommonArgs**](CommonArgs.md) | Common arguments for the request | 

## Example

```python
from hello_kv_client.models.body_set_logic_kv_set_post import BodySetLogicKvSetPost

# TODO update the JSON string below
json = "{}"
# create an instance of BodySetLogicKvSetPost from a JSON string
body_set_logic_kv_set_post_instance = BodySetLogicKvSetPost.from_json(json)
# print the JSON string representation of the object
print(BodySetLogicKvSetPost.to_json())

# convert the object into a dict
body_set_logic_kv_set_post_dict = body_set_logic_kv_set_post_instance.to_dict()
# create an instance of BodySetLogicKvSetPost from a dict
body_set_logic_kv_set_post_form_dict = body_set_logic_kv_set_post.from_dict(body_set_logic_kv_set_post_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


