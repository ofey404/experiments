# hello_kv_client.DefaultApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_logic_kv_get_post**](DefaultApi.md#get_logic_kv_get_post) | **POST** /kv/get | Get Logic
[**set_logic_kv_set_post**](DefaultApi.md#set_logic_kv_set_post) | **POST** /kv/set | Set Logic


# **get_logic_kv_get_post**
> GetResponse get_logic_kv_get_post(body_get_logic_kv_get_post)

Get Logic

### Example


```python
import hello_kv_client
from hello_kv_client.models.body_get_logic_kv_get_post import BodyGetLogicKvGetPost
from hello_kv_client.models.get_response import GetResponse
from hello_kv_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to http://localhost
# See configuration.py for a list of all supported configuration parameters.
configuration = hello_kv_client.Configuration(
    host = "http://localhost"
)


# Enter a context with an instance of the API client
with hello_kv_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = hello_kv_client.DefaultApi(api_client)
    body_get_logic_kv_get_post = hello_kv_client.BodyGetLogicKvGetPost() # BodyGetLogicKvGetPost | 

    try:
        # Get Logic
        api_response = api_instance.get_logic_kv_get_post(body_get_logic_kv_get_post)
        print("The response of DefaultApi->get_logic_kv_get_post:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->get_logic_kv_get_post: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body_get_logic_kv_get_post** | [**BodyGetLogicKvGetPost**](BodyGetLogicKvGetPost.md)|  | 

### Return type

[**GetResponse**](GetResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Successful Response |  -  |
**422** | Validation Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **set_logic_kv_set_post**
> SetResponse set_logic_kv_set_post(body_set_logic_kv_set_post)

Set Logic

### Example


```python
import hello_kv_client
from hello_kv_client.models.body_set_logic_kv_set_post import BodySetLogicKvSetPost
from hello_kv_client.models.set_response import SetResponse
from hello_kv_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to http://localhost
# See configuration.py for a list of all supported configuration parameters.
configuration = hello_kv_client.Configuration(
    host = "http://localhost"
)


# Enter a context with an instance of the API client
with hello_kv_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = hello_kv_client.DefaultApi(api_client)
    body_set_logic_kv_set_post = hello_kv_client.BodySetLogicKvSetPost() # BodySetLogicKvSetPost | 

    try:
        # Set Logic
        api_response = api_instance.set_logic_kv_set_post(body_set_logic_kv_set_post)
        print("The response of DefaultApi->set_logic_kv_set_post:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->set_logic_kv_set_post: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body_set_logic_kv_set_post** | [**BodySetLogicKvSetPost**](BodySetLogicKvSetPost.md)|  | 

### Return type

[**SetResponse**](SetResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Successful Response |  -  |
**422** | Validation Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

