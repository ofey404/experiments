import hello_kv_client
from hello_kv_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to http://localhost
# See configuration.py for a list of all supported configuration parameters.
configuration = hello_kv_client.Configuration(
    host = "http://localhost:8888"
)



# Enter a context with an instance of the API client
with hello_kv_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = hello_kv_client.DefaultApi(api_client)
    body_get_logic_kv_get_post = hello_kv_client.BodyGetLogicKvGetPost(
        key="key",
        common_args=hello_kv_client.CommonArgs(
            foo="foo",
            bar=1,
        )
    ) # BodyGetLogicKvGetPost | 

    try:
        # Get Logic
        api_response = api_instance.get_logic_kv_get_post(body_get_logic_kv_get_post)
        print("The response of DefaultApi->get_logic_kv_get_post:\n")
        pprint(api_response)
    except ApiException as e:
        print("Exception when calling DefaultApi->get_logic_kv_get_post: %s\n" % e)