import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String? baseUrl}) = _AuthApiClient;
}
