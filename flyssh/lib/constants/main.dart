import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flyssh_api/flyssh_api.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: kDebugMode
        ? Platform.isMacOS
              ? 'http://localhost:8080'
              : 'http://192.168.1.9:8080'
        : 'https://api.flyssh.com',
  ),
);

final openapi = FlysshApi(dio: dio);

final TOKEN_KEY = 'auth_token';
final double BASE_SPACE = 4.0;
