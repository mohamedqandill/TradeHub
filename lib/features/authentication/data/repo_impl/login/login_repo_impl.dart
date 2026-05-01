import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/utils/dio/dio_services.dart';
import 'package:tradehub/core/utils/secure_storage/secure_storage_service.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/login/login_data_source_contract.dart';
import 'package:tradehub/features/authentication/data/models/login/login_request_body.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/login/login_repo_contract.dart';

import '../../../../../core/utils/di/di.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  LoginDataSourceContract _loginDataSourceContract;

  LoginRepoImpl(this._loginDataSourceContract);

  @override
  Future<ApiResult<void>> login(
      {required LoginRequestBody loginBody, required bool isRememberMe}) async {
    var result = await _loginDataSourceContract.login(loginBody: loginBody);
    switch (result) {
      case Success():
        if (isRememberMe) {
          await getIt<SecureStorageHelper>()
              .write(ApiConstants.token, result.data!.token!);
          
        } else {
          final session = getIt<SessionManager>();
          session.token = result.data!.token!;
        
        }
        Map<dynamic, dynamic> userInfo = {
          "fullName": result.data?.fullName,
          "email": result.data?.email,
          "phone": result.data?.phoneNumber,
        };
        await getIt<HiveStorageHelper>()
            .saveMap(AppConstants.userInfo, userInfo);
        return Success(data: null);
      case Error():
        return Error(error: result.error);
    }
  }
}

@singleton
class SessionManager {
  String? token;
}
