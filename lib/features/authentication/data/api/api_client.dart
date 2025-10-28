import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/features/authentication/data/models/register/register_response.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';
import '../../../../core/api/api_constant/api_constant.dart';
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

  @POST(ApiEndPoints.sendOTP)
  Future<String> sendOTP({@Body() required Map<String, dynamic> email});

  @POST(ApiEndPoints.verifyAccount)
  Future<String> verifyAccount(
      {@Body() required Map<String, dynamic> verifyAccountBody});

  @GET(ApiEndPoints.signWithGoogle)
  Future<void> signWithGoogle(
      {@Query(ApiConstants.accessToken) required String accessToken});
  @GET(ApiEndPoints.signWithFacebook)
  Future<void> signWithFacebook(
      {@Query(ApiConstants.accessToken) required String accessToken});
}
