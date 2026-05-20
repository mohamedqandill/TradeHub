import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../api/change_password_api_client.dart';
import '../models/change_password_request_body.dart';
import 'change_password_repository.dart';

@Injectable(as: ChangePasswordRepository)
class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordApiClient _apiClient;

  ChangePasswordRepositoryImpl(this._apiClient);

  @override
  Future<ApiResult<void>> changePassword({required ChangePasswordRequestBody body}) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.changePassword(body: body),
    );
  }
}
