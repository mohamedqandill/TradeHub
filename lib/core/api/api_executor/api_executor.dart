import 'package:dio/dio.dart';
import 'package:tradehub/core/api/api_errors/api_error_handler.dart';
import 'package:tradehub/core/api/api_errors/api_error_model.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';

abstract class ApiExecutor {
  static Future<ApiResult<T>> executeApi<T>(
      {required Future<T> Function() apiCall}) async {
    try {
      var result = await apiCall.call();
      return Success(data: result);
    } on DioException catch (dioError) {
      var serverException = handleDioErrors(dioError);
      return Error(error: serverException.errorsModel);
    } catch (error) {
      return Error(error: ErrorsModel(message: "Unexpected error occurred."));
    }
  }
}
