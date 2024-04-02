# SetResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**updated** | **bool** |  | 
**old_value** | [**OldValue**](OldValue.md) |  | [optional] 

## Example

```python
from hello_kv_client.models.set_response import SetResponse

# TODO update the JSON string below
json = "{}"
# create an instance of SetResponse from a JSON string
set_response_instance = SetResponse.from_json(json)
# print the JSON string representation of the object
print(SetResponse.to_json())

# convert the object into a dict
set_response_dict = set_response_instance.to_dict()
# create an instance of SetResponse from a dict
set_response_form_dict = set_response.from_dict(set_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


