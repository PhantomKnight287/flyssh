# openapi.api.HostsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**hostsControllerCreate**](HostsApi.md#hostscontrollercreate) | **POST** /hosts | Create new host
[**hostsControllerFindAll**](HostsApi.md#hostscontrollerfindall) | **GET** /hosts | Get all hosts
[**hostsControllerFindOne**](HostsApi.md#hostscontrollerfindone) | **GET** /hosts/{id} | Get details of a host
[**hostsControllerRemove**](HostsApi.md#hostscontrollerremove) | **DELETE** /hosts/{id} | Delete host
[**hostsControllerUpdate**](HostsApi.md#hostscontrollerupdate) | **PATCH** /hosts/{id} | Update host


# **hostsControllerCreate**
> GenericResponseDto hostsControllerCreate(createHostDto)

Create new host

Create new host

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHostsApi();
final CreateHostDto createHostDto = ; // CreateHostDto | 

try {
    final response = api.hostsControllerCreate(createHostDto);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createHostDto** | [**CreateHostDto**](CreateHostDto.md)|  | 

### Return type

[**GenericResponseDto**](GenericResponseDto.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsControllerFindAll**
> BuiltList<PartialHost> hostsControllerFindAll(page, limit)

Get all hosts

Get all hosts(requires pagination)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHostsApi();
final num page = 8.14; // num | The page no for pagination(must start with 1)
final num limit = 8.14; // num | No of records to return(must stay constant for a transaction)

try {
    final response = api.hostsControllerFindAll(page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| The page no for pagination(must start with 1) | 
 **limit** | **num**| No of records to return(must stay constant for a transaction) | 

### Return type

[**BuiltList&lt;PartialHost&gt;**](PartialHost.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsControllerFindOne**
> Host hostsControllerFindOne(id)

Get details of a host

Get all details of a host

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHostsApi();
final String id = id_example; // String | The id of the host

try {
    final response = api.hostsControllerFindOne(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsControllerFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| The id of the host | 

### Return type

[**Host**](Host.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsControllerRemove**
> GenericResponseDto hostsControllerRemove(id)

Delete host

Delete host

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHostsApi();
final String id = id_example; // String | The id of the host

try {
    final response = api.hostsControllerRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| The id of the host | 

### Return type

[**GenericResponseDto**](GenericResponseDto.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hostsControllerUpdate**
> GenericResponseDto hostsControllerUpdate(id, updateHostDto)

Update host

Update host

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHostsApi();
final String id = id_example; // String | The id of the host
final UpdateHostDto updateHostDto = ; // UpdateHostDto | 

try {
    final response = api.hostsControllerUpdate(id, updateHostDto);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HostsApi->hostsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| The id of the host | 
 **updateHostDto** | [**UpdateHostDto**](UpdateHostDto.md)|  | 

### Return type

[**GenericResponseDto**](GenericResponseDto.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

