# openapi.api.AuthenticationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerGetCurrentUser**](AuthenticationApi.md#authcontrollergetcurrentuser) | **GET** /auth/@me | Get current user
[**authControllerLogin**](AuthenticationApi.md#authcontrollerlogin) | **POST** /auth/login | Login
[**authControllerRegister**](AuthenticationApi.md#authcontrollerregister) | **POST** /auth/sign-up | Signup


# **authControllerGetCurrentUser**
> UserEntity authControllerGetCurrentUser()

Get current user

Get current user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticationApi();

try {
    final response = api.authControllerGetCurrentUser();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->authControllerGetCurrentUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerLogin**
> LoginEntity authControllerLogin(loginDTO)

Login

Login

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticationApi();
final LoginDTO loginDTO = ; // LoginDTO | 

try {
    final response = api.authControllerLogin(loginDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->authControllerLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginDTO** | [**LoginDTO**](LoginDTO.md)|  | 

### Return type

[**LoginEntity**](LoginEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerRegister**
> SignupEntity authControllerRegister(signupDTO)

Signup

Signup

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticationApi();
final SignupDTO signupDTO = ; // SignupDTO | 

try {
    final response = api.authControllerRegister(signupDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->authControllerRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signupDTO** | [**SignupDTO**](SignupDTO.md)|  | 

### Return type

[**SignupEntity**](SignupEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

