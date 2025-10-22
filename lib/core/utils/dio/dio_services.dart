import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/core/constants/app_constants.dart';

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
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        });
  }

  @singleton
  Dio provideDio(PrettyDioLogger logger) {
    var dio = Dio();
    dio.interceptors.add(logger);
    return dio;
  }

  @Named(AppConstants.baseUrl)
  String get baseUrl => ApiEndPoints.baseURL;
}
