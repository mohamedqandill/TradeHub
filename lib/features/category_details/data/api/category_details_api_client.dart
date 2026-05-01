import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/features/category_details/data/models/category_company_dto.dart';

part 'category_details_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class CategoryDetailsApiClient {
  @factoryMethod
  factory CategoryDetailsApiClient(
    Dio dio, {
    @Named('baseUrl') String? baseUrl,
  }) = _CategoryDetailsApiClient;

  @GET("${ApiEndPoints.companiesByCategory}{categoryId}")
  Future<List<CategoryCompanyDTO>> getCompaniesByCategory(
    @Path("categoryId") int categoryId,
  );
}
