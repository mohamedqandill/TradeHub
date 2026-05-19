import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/shared_services/signalr_connection.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/firebase_service/social_auth.dart';
import 'package:tradehub/core/utils/secure_storage/secure_storage_service.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/authentication/data/api/api_client.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/register/register_data_source.dart';
import 'package:tradehub/features/authentication/data/models/login/login_response_dto.dart';
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

  @override
  Future<ApiResult<String>> sendOTP({required String email}) async {
    var result = await ApiExecutor.executeApi(
      apiCall: () =>
          _authApiClient.sendOTP(email: {ApiConstants.phoneOrEmail: email}),
    );
    switch (result) {
      case Error():
        return Error(error: result.error);
      case Success():
        return Success(data: result.data.toString());
    }
  }

  @override
  Future<ApiResult<String>> verifyAccount(
      {required String email, required String phone}) async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.verifyAccount(verifyAccountBody: {
        ApiConstants.emailCap: email,
        ApiConstants.phone: phone
      }),
    );
    switch (result) {
      case Success():
        return Success(data: result.data);
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<LoginResponseDTO>> signWithGoogle() async {
    var user = await SocialAuthFirebase.signInWithGoogle();
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.signWithGoogle(accessToken: {
        ApiConstants.capAccessToken: user.credential!.accessToken!
      }),
    );

    switch (result) {
      case Error():
        return Error(error: result.error);
      case Success():
        await getIt<SecureStorageHelper>()
            .write(ApiConstants.token, result.data?.token ?? "");
        Map<dynamic, dynamic> userInfo = {
          ApiConstants.fullName: result.data?.fullName ?? "",
          ApiConstants.email: result.data?.email ?? "",
          ApiConstants.phoneNumber: result.data?.phoneNumber ?? "",
          ApiConstants.profilePicture: result.data?.profilePicture ?? "",
        };
        SignalRService().start(result.data!.token ?? "");
        await getIt<HiveStorageHelper>()
            .saveMap(AppConstants.userInfo, userInfo);

        return Success(data: null);
    }
  }

  @override
  Future<ApiResult<void>> signWithFacebook() async {
    var user = await SocialAuthFirebase.signInWithFacebook();
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.signWithFacebook(accessToken: {
        ApiConstants.capAccessToken: user.credential!.accessToken!
      }),
    );
    switch (result) {
      case Error():
        return Error(error: result.error);
      case Success():
        return Success(data: null);
    }
  }
}
