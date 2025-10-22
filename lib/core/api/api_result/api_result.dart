import 'package:tradehub/core/api/api_errors/api_error_model.dart';

sealed class ApiResult<T> {}

class Success<T> extends ApiResult<T> {
  T? data;

  Success({required this.data});
}

class Error<T> extends ApiResult<T> {
  ErrorsModel? error;

  Error({required this.error});
}
