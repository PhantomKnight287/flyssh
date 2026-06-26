# flyssh_api.api.KeysApi

## Load the API package
```dart
import 'package:flyssh_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**keysGet**](KeysApi.md#keysget) | **GET** /keys | List all SSH keys
[**keysIdDelete**](KeysApi.md#keysiddelete) | **DELETE** /keys/{id} | Delete an SSH key
[**keysIdGet**](KeysApi.md#keysidget) | **GET** /keys/{id} | Get a single SSH key
[**keysIdPut**](KeysApi.md#keysidput) | **PUT** /keys/{id} | Update an SSH key
[**keysPost**](KeysApi.md#keyspost) | **POST** /keys | Create a new SSH key


# **keysGet**
> List<KeysKeyResponse> keysGet(authorization)

List all SSH keys

Return all SSH keys belonging to the authenticated user.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getKeysApi();
final String authorization = authorization_example; // String | Bearer token

try {
    final response = api.keysGet(authorization);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 

### Return type

[**List&lt;KeysKeyResponse&gt;**](KeysKeyResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **keysIdDelete**
> Map<String, String> keysIdDelete(authorization, id)

Delete an SSH key

Delete an SSH key by ID. Associated hosts will have their keyId set to null.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getKeysApi();
final String authorization = authorization_example; // String | Bearer token
final int id = 56; // int | Key ID

try {
    final response = api.keysIdDelete(authorization, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **id** | **int**| Key ID | 

### Return type

**Map&lt;String, String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **keysIdGet**
> KeysKeyResponse keysIdGet(authorization, id)

Get a single SSH key

Return an SSH key by ID. Must belong to the authenticated user.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getKeysApi();
final String authorization = authorization_example; // String | Bearer token
final int id = 56; // int | Key ID

try {
    final response = api.keysIdGet(authorization, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **id** | **int**| Key ID | 

### Return type

[**KeysKeyResponse**](KeysKeyResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **keysIdPut**
> KeysKeyResponse keysIdPut(authorization, id, keysUpdateKeyRequest)

Update an SSH key

Update fields of an existing SSH key. All fields are optional.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getKeysApi();
final String authorization = authorization_example; // String | Bearer token
final int id = 56; // int | Key ID
final KeysUpdateKeyRequest keysUpdateKeyRequest = ; // KeysUpdateKeyRequest | Fields to update

try {
    final response = api.keysIdPut(authorization, id, keysUpdateKeyRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **id** | **int**| Key ID | 
 **keysUpdateKeyRequest** | [**KeysUpdateKeyRequest**](KeysUpdateKeyRequest.md)| Fields to update | 

### Return type

[**KeysKeyResponse**](KeysKeyResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **keysPost**
> KeysKeyResponse keysPost(authorization, keysCreateKeyRequest)

Create a new SSH key

Store a client-encrypted SSH key. The value and optional passphrase are opaque encrypted blobs.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getKeysApi();
final String authorization = authorization_example; // String | Bearer token
final KeysCreateKeyRequest keysCreateKeyRequest = ; // KeysCreateKeyRequest | Key details

try {
    final response = api.keysPost(authorization, keysCreateKeyRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **keysCreateKeyRequest** | [**KeysCreateKeyRequest**](KeysCreateKeyRequest.md)| Key details | 

### Return type

[**KeysKeyResponse**](KeysKeyResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

