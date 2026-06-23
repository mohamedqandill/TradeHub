import "package:dio/dio.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

import '../../localization/locale_keys.g.dart';
import 'api_error_model.dart';

ServerExceptions handleDioErrors(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ServerExceptions(
          errorsModel:
              ErrorsModel(message: LocaleKeys.errorConnectionTimeout.tr()));

    case DioExceptionType.sendTimeout:
      return ServerExceptions(
          errorsModel: ErrorsModel(message: LocaleKeys.errorSendTimeout.tr()));

    case DioExceptionType.receiveTimeout:
      return ServerExceptions(
          errorsModel:
              ErrorsModel(message: LocaleKeys.errorReceiveTimeout.tr()));

    case DioExceptionType.connectionError:
      return ServerExceptions(
          errorsModel:
              ErrorsModel(message: LocaleKeys.errorConnectionError.tr()));

    case DioExceptionType.cancel:
      return ServerExceptions(
          errorsModel: ErrorsModel(message: LocaleKeys.errorCancel.tr()));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 401:
          return ServerExceptions(
              errorsModel:
                  ErrorsModel(message: e.response!.data[ApiConstants.message]));
        case 400:
          return ServerExceptions(
              errorsModel:
                  ErrorsModel(message: e.response!.data[ApiConstants.message]));
        case 404:
          return ServerExceptions(
              errorsModel:
                  ErrorsModel(message: e.response!.data[ApiConstants.message]));
        case 500:
        case 502:
        case 503:
        case 504:
          return ServerExceptions(
              errorsModel:
                  ErrorsModel(message: e.response!.data[ApiConstants.message]));
        default:
          return ServerExceptions(
              errorsModel:
                  ErrorsModel(message: e.response!.data[ApiConstants.message]));
      }

    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
    default:
      return ServerExceptions(
          errorsModel: ErrorsModel(message: LocaleKeys.errorUnexpected.tr()));
  }
}
