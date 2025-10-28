import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/api/api_client.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/login/login_data_source_contract.dart';
import 'package:tradehub/features/authentication/data/models/login/login_response_dto.dart';

import '../../models/login/login_request_body.dart';

@Injectable(as: LoginDataSourceContract)
class LoginDataSourceImpl implements LoginDataSourceContract {
  final AuthApiClient _authApiClient;

  LoginDataSourceImpl(this._authApiClient);

  @override
  Future<ApiResult<LoginResponseDTO>> login(
      {required LoginRequestBody loginBody}) async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.login(loginRequestBody: loginBody),
    );
    switch (result) {
      case Success():
        return Success(data: result.data);
      case Error():
        return Error(error: result.error);
    }
  }
}
