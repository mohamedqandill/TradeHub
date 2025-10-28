import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  Future<ApiResult<String>> sendOTP({required String email}) async {
    var result = await ApiExecutor.executeApi(
      apiCall: () async {
        return await _authApiClient
            .sendOTP(email: {ApiConstants.phoneOrEmail: email});
      },
    );
    switch (result) {
      case Error():
        return Error(error: result.error);
      case Success():
        return Success(data: result.data);
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
  Future<ApiResult<void>> signWithGoogle() async {
    var user = await signInWithGoogle();
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.signWithGoogle(
          accessToken: user.credential!.accessToken!),
    );
    switch (result) {
      case Error():
        return Error(error: result.error);
      case Success():
        return Success(data: null);
    }
  }

  @override
  Future<ApiResult<void>> signWithFacebook() async {
    var user = await signInWithFacebook();
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.signWithFacebook(
          accessToken: user.credential!.accessToken!),
    );
    switch (result) {
      case Error():
        return Error(error: result.error);
      case Success():
        return Success(data: null);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
