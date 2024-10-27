# openapi.api.KeysApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**keysControllerCreate**](KeysApi.md#keyscontrollercreate) | **POST** /keys | Create a key
[**keysControllerFindAll**](KeysApi.md#keyscontrollerfindall) | **GET** /keys | Get all keys


# **keysControllerCreate**
> GenericResponseDto keysControllerCreate(createKeyDTO)

Create a key

Create a key

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getKeysApi();
final CreateKeyDTO createKeyDTO = ; // CreateKeyDTO | 

try {
    final response = api.keysControllerCreate(createKeyDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createKeyDTO** | [**CreateKeyDTO**](CreateKeyDTO.md)|  | 

### Return type

[**GenericResponseDto**](GenericResponseDto.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **keysControllerFindAll**
> BuiltList<PartialKey> keysControllerFindAll(page, limit)

Get all keys

Get all keys(requires pagination)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getKeysApi();
final num page = 8.14; // num | The page no for pagination(must start with 1)
final num limit = 8.14; // num | No of records to return(must stay constant for a transaction)

try {
    final response = api.keysControllerFindAll(page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling KeysApi->keysControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| The page no for pagination(must start with 1) | 
 **limit** | **num**| No of records to return(must stay constant for a transaction) | 

### Return type

[**BuiltList&lt;PartialKey&gt;**](PartialKey.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

