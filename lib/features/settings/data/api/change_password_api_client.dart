import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import '../models/change_password_request_body.dart';

part 'change_password_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _ChangePasswordApiClient;

  @POST(ApiEndPoints.changePassword)
  Future<void> changePassword({@Body() required ChangePasswordRequestBody body});
}
