import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flyssh/interceptors/auth.dart';
import 'package:openapi/openapi.dart';

final API_URL = kDebugMode
    ? Platform.isAndroid
        ? "http://10.0.2.2:3000"
        : "http://localhost:3000"
    : "";

final openapi = Openapi(
  dio: Dio(
    BaseOptions(
      baseUrl: API_URL,
    ),
  ),
  interceptors: [
    TokenInterceptor(),
  ],
);

const BASE_SPACE = 4.0;

// these are to prevent magic strings in codebase
const AUTH_TOKEN_KEY = "token";
const MASTER_KEY_KEY = "master_key";

const PAGE_SIZE = 20;
