import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/api/api_client.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/register/register_data_source.dart';
import 'package:tradehub/features/authentication/data/models/register/register_body.dart';
import 'package:tradehub/features/authentication/data/models/register/register_request_body.dart';
import 'package:tradehub/features/authentication/domain/entites/register/register_entity.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImpl implements RegisterDataSource {
  AuthApiClient _authApiClient;

  RegisterDataSourceImpl(this._authApiClient);

  @override
  Future<ApiResult<RegisterEntity>> register(
      {required RegisterBody registerBody}) async {
    var result = await ApiExecutor.executeApi(
        apiCall: () async => await _authApiClient.register(
            registerRequest: RegisterRequestBody(
                email: registerBody.email,
                password: registerBody.password,
                firstName: registerBody.firstName,
                lastName: registerBody.lastName,
                phoneNumber: registerBody.phoneNumber,
                accountType: ApiConstants.accountTypeValue,
                loginProvider: ApiConstants.loginProviderValue)));
    switch (result) {
      case Success():
        return Success(data: result.data!.toEntity());
      case Error():
        return Error(error: result.error);
    }
  }
}
