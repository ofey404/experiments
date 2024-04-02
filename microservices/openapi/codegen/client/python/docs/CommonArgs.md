# CommonArgs


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**foo** | **str** |  | 
**bar** | **int** |  | 

## Example

```python
from hello_kv_client.models.common_args import CommonArgs

# TODO update the JSON string below
json = "{}"
# create an instance of CommonArgs from a JSON string
common_args_instance = CommonArgs.from_json(json)
# print the JSON string representation of the object
print(CommonArgs.to_json())

# convert the object into a dict
common_args_dict = common_args_instance.to_dict()
# create an instance of CommonArgs from a dict
common_args_form_dict = common_args.from_dict(common_args_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


