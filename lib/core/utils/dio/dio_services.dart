import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';

import '../di/di.dart';

@module
abstract class DioServices {
  @singleton
  PrettyDioLogger provideDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    );
  }

  @singleton
  Dio provideDio(PrettyDioLogger logger) {
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        contentType: "application/json",
        receiveTimeout: const Duration(seconds: 20),
        baseUrl: ApiEndPoints.baseURL));
    dio.interceptors.add(logger);
    return dio;
  }

  @Named("baseUrl")
  String get baseUrl => ApiEndPoints.baseURL;
}

extension DioServiceExtension on DioServices {
  static void updateDioWithToken(String token) {
    Dio dio = getIt.get<Dio>();
    BaseOptions newBaseOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        baseUrl: ApiEndPoints.baseURL,
        headers: {
          "Authorization": token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    dio.options = newBaseOptions;
  }
}
