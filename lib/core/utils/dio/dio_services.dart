import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/core/utils/secure_storage/secure_storage_service.dart';

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
      enabled: kDebugMode,
    );
  }

  @preResolve
  @singleton
  Future<CookieJar> provideCookieJar() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/cookies/';
    final folder = Directory(path);

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    return PersistCookieJar(storage: FileStorage(path));
  }

  @singleton
  Dio provideDio(PrettyDioLogger logger, CookieJar cookieJar) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseURL,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
        },

        /// 🔥 مهم جداً عشان 401 يدخل onError
        validateStatus: (status) => status != null && status < 400,
      ),
    );

    dio.interceptors.add(CookieManager(cookieJar));
    

    /// 🔐 Request Interceptor (يحط التوكن دايماً)
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await getIt<SecureStorageHelper>().read(ApiConstants.token);

          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );

    /// 🔁 Refresh Logic
    bool isRefreshing = false;
    final List<Map<String, dynamic>> requestQueue = [];

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException err, handler) async {
          final status = err.response?.statusCode;

          if (status == 401) {
            final requestOptions = err.requestOptions;

            /// لو refresh نفسه فشل → logout
            if (requestOptions.path.contains('refresh-token')) {
              await getIt<SecureStorageHelper>().delete(ApiConstants.token);
              await cookieJar.deleteAll();
              return handler.next(err);
            }

            if (isRefreshing) {
              final completer = Completer<Response>();
              requestQueue.add({
                'options': requestOptions,
                'completer': completer,
              });
              return completer.future
                  .then((value) => handler.resolve(value))
                  .catchError((e) => handler.reject(e));
            }

            isRefreshing = true;

            final refreshDio = Dio(
              BaseOptions(
                baseUrl: ApiEndPoints.baseURL,
                validateStatus: (status) => status != null && status < 500,
              ),
            );

            refreshDio.interceptors.add(CookieManager(cookieJar));

            try {
              final response =
                  await refreshDio.get('api/account/refresh-token');

              if (response.statusCode == 200) {
                final newToken = response.data['token'];

                /// 💾 حفظ التوكن
                await getIt<SecureStorageHelper>()
                    .write(ApiConstants.token, newToken);

                /// 🔄 تحديث الهيدر
                dio.options.headers['Authorization'] = "Bearer $newToken";

                /// 🔁 إعادة الطلب الأصلي
                requestOptions.headers['Authorization'] = "Bearer $newToken";
                final retryResponse = await dio.fetch(requestOptions);

                /// 🔥 نفذ كل الـ queue
                for (var request in requestQueue) {
                  final options = request['options'] as RequestOptions;
                  final completer = request['completer'] as Completer<Response>;
                  options.headers['Authorization'] = "Bearer $newToken";
                  completer.complete(dio.fetch(options));
                }
                requestQueue.clear();

                return handler.resolve(retryResponse);
              }
            } catch (e) {
              /// ❌ فشل refresh → logout
              await getIt<SecureStorageHelper>().delete(ApiConstants.token);
              await cookieJar.deleteAll();

              for (var request in requestQueue) {
                final completer = request['completer'] as Completer<Response>;
                completer.completeError(e);
              }
              requestQueue.clear();
              return handler.next(err);
            } finally {
              isRefreshing = false;
            }
          }

          return handler.next(err);
        },
      ),
    );
    dio.interceptors.add(logger);

    return dio;
  }

  @Named("baseUrl")
  String get baseUrl => ApiEndPoints.baseURL;
}

Future<String?> getToken() async {
  var token = getIt<SecureStorageHelper>().read(ApiConstants.token);
  return token;
}
