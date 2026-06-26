# flyssh_api.api.AuthApi

## Load the API package
```dart
import 'package:flyssh_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authLoginPost**](AuthApi.md#authloginpost) | **POST** /auth/login | Login a user
[**authRecoverPost**](AuthApi.md#authrecoverpost) | **POST** /auth/recover | Recover encrypted master key
[**authRecoverySetupPost**](AuthApi.md#authrecoverysetuppost) | **POST** /auth/recovery/setup | Store encrypted master key for recovery
[**authRegisterPost**](AuthApi.md#authregisterpost) | **POST** /auth/register | Register a new user


# **authLoginPost**
> AuthLoginUserResponse authLoginPost(authLoginUserRequest)

Login a user

Authenticate a user with username, password and masterKeyHash. The client derives authKey = PBKDF2(masterKey, email) and sends it as masterKeyHash. The server verifies it against the stored bcrypt hash.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getAuthApi();
final AuthLoginUserRequest authLoginUserRequest = ; // AuthLoginUserRequest | Login details

try {
    final response = api.authLoginPost(authLoginUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authLoginUserRequest** | [**AuthLoginUserRequest**](AuthLoginUserRequest.md)| Login details | 

### Return type

[**AuthLoginUserResponse**](AuthLoginUserResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRecoverPost**
> AuthRecoverResponse authRecoverPost(authRecoverRequest)

Recover encrypted master key

Verify username, password, and recovery key, then return the encrypted master key blob. The client decrypts it locally. No JWT is issued — call /auth/login afterward.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getAuthApi();
final AuthRecoverRequest authRecoverRequest = ; // AuthRecoverRequest | Recovery credentials

try {
    final response = api.authRecoverPost(authRecoverRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authRecoverPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authRecoverRequest** | [**AuthRecoverRequest**](AuthRecoverRequest.md)| Recovery credentials | 

### Return type

[**AuthRecoverResponse**](AuthRecoverResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRecoverySetupPost**
> ModelsGenericResponse authRecoverySetupPost(authSetupRecoveryRequest)

Store encrypted master key for recovery

After registration, the client encrypts the raw master key using the recovery key (AES-GCM, client-side) and sends the encrypted blob to the server for storage.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getAuthApi();
final AuthSetupRecoveryRequest authSetupRecoveryRequest = ; // AuthSetupRecoveryRequest | Encrypted master key blob

try {
    final response = api.authRecoverySetupPost(authSetupRecoveryRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authRecoverySetupPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authSetupRecoveryRequest** | [**AuthSetupRecoveryRequest**](AuthSetupRecoveryRequest.md)| Encrypted master key blob | 

### Return type

[**ModelsGenericResponse**](ModelsGenericResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRegisterPost**
> AuthRegisterUserResponse authRegisterPost(authRegisterUserRequest)

Register a new user

Create a new user account. The client must generate a master key locally, derive an authKey via PBKDF2(masterKey, email), and send the authKey as masterKeyHash. The server never sees the raw master key.

### Example
```dart
import 'package:flyssh_api/api.dart';

final api = FlysshApi().getAuthApi();
final AuthRegisterUserRequest authRegisterUserRequest = ; // AuthRegisterUserRequest | Registration details

try {
    final response = api.authRegisterPost(authRegisterUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authRegisterUserRequest** | [**AuthRegisterUserRequest**](AuthRegisterUserRequest.md)| Registration details | 

### Return type

[**AuthRegisterUserResponse**](AuthRegisterUserResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

