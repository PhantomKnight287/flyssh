# flyssh_api.api.HostsApi

## Load the API package
```dart
import 'package:flyssh_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**hostsGet**](HostsApi.md#hostsget) | **GET** /hosts | List all hosts
[**hostsIdDelete**](HostsApi.md#hostsiddelete) | **DELETE** /hosts/{id} | Delete a host
[**hostsIdGet**](HostsApi.md#hostsidget) | **GET** /hosts/{id} | Get a single host
[**hostsIdPut**](HostsApi.md#hostsidput) | **PUT** /hosts/{id} | Update a host
[**hostsPost**](HostsApi.md#hostspost) | **POST** /hosts | Create a new host


# **hostsGet**
> List<HostsHostResponse> hostsGet(authorization)

List all hosts

Return all SSH hosts belonging to the authenticated user, with keys preloaded.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getHostsApi();
final String authorization = authorization_example; // String | Bearer token

try {
    final response = api.hostsGet(authorization);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 

### Return type

[**List&lt;HostsHostResponse&gt;**](HostsHostResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsIdDelete**
> Map<String, String> hostsIdDelete(authorization, id)

Delete a host

Delete an SSH host by ID. Must belong to the authenticated user.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getHostsApi();
final String authorization = authorization_example; // String | Bearer token
final int id = 56; // int | Host ID

try {
    final response = api.hostsIdDelete(authorization, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **id** | **int**| Host ID | 

### Return type

**Map&lt;String, String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsIdGet**
> HostsHostResponse hostsIdGet(authorization, id)

Get a single host

Return an SSH host by ID with its key preloaded. Must belong to the authenticated user.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getHostsApi();
final String authorization = authorization_example; // String | Bearer token
final int id = 56; // int | Host ID

try {
    final response = api.hostsIdGet(authorization, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **id** | **int**| Host ID | 

### Return type

[**HostsHostResponse**](HostsHostResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsIdPut**
> HostsHostResponse hostsIdPut(authorization, id, hostsUpdateHostRequest)

Update a host

Update fields of an existing SSH host. All fields are optional. If keyId is provided, the key must belong to the same user.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getHostsApi();
final String authorization = authorization_example; // String | Bearer token
final int id = 56; // int | Host ID
final HostsUpdateHostRequest hostsUpdateHostRequest = ; // HostsUpdateHostRequest | Fields to update

try {
    final response = api.hostsIdPut(authorization, id, hostsUpdateHostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **id** | **int**| Host ID | 
 **hostsUpdateHostRequest** | [**HostsUpdateHostRequest**](HostsUpdateHostRequest.md)| Fields to update | 

### Return type

[**HostsHostResponse**](HostsHostResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsPost**
> HostsHostResponse hostsPost(authorization, hostsCreateHostRequest)

Create a new host

Store an SSH host configuration. Password is a client-encrypted blob. A key can optionally be attached.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getHostsApi();
final String authorization = authorization_example; // String | Bearer token
final HostsCreateHostRequest hostsCreateHostRequest = ; // HostsCreateHostRequest | Host details

try {
    final response = api.hostsPost(authorization, hostsCreateHostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| Bearer token | 
 **hostsCreateHostRequest** | [**HostsCreateHostRequest**](HostsCreateHostRequest.md)| Host details | 

### Return type

[**HostsHostResponse**](HostsHostResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

