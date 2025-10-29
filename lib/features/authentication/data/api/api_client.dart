import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/features/authentication/data/models/login/login_request_body.dart';
import 'package:tradehub/features/authentication/data/models/login/login_response_dto.dart';
import 'package:tradehub/features/authentication/data/models/register/register_response.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';
import '../models/register/register_request_body.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@injectable
@singleton
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio, {@Named("baseUrl") String? baseUrl}) =
      _AuthApiClient;

  @POST(ApiEndPoints.register)
  Future<RegisterResponse> register(
      {@Body() required RegisterRequestBody registerRequest});
  @POST(ApiEndPoints.login)
  Future<LoginResponseDTO> login(
      {@Body() required LoginRequestBody loginRequestBody});

  @POST(ApiEndPoints.sendOTP)
  Future<String> sendOTP({@Body() required Map<String, dynamic> email});

  @POST(ApiEndPoints.verifyAccount)
  Future<String> verifyAccount(
      {@Body() required Map<String, dynamic> verifyAccountBody});

  @POST(ApiEndPoints.signWithGoogle)
  Future<void> signWithGoogle(
      {@Body() required Map<String, dynamic> accessToken});
  @POST(ApiEndPoints.signWithFacebook)
  Future<void> signWithFacebook(
      {@Body() required Map<String, dynamic> accessToken});
}
