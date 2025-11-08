import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/api/api_client.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/new_password/new_password_data_source_contract.dart';

import '../../models/new_password/new_password_request_body.dart';

@Injectable(as: NewPasswordDataSourceContract)
class NewPasswordDataSourceImpl implements NewPasswordDataSourceContract {
  final AuthApiClient _authApiClient;

  NewPasswordDataSourceImpl(this._authApiClient);

  @override
  Future<ApiResult<void>> newPassword(
      {required NewPasswordRequestBody body}) async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.newPassword(body: body),
    );
    switch (result) {
      case Success():
        return Success(data: null);
      case Error():
        return Error(error: result.error);
    }
  }
}
