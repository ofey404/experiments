# GetResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**key** | **str** |  | 
**value** | **str** |  | 

## Example

```python
from hello_kv_client.models.get_response import GetResponse

# TODO update the JSON string below
json = "{}"
# create an instance of GetResponse from a JSON string
get_response_instance = GetResponse.from_json(json)
# print the JSON string representation of the object
print(GetResponse.to_json())

# convert the object into a dict
get_response_dict = get_response_instance.to_dict()
# create an instance of GetResponse from a dict
get_response_form_dict = get_response.from_dict(get_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


