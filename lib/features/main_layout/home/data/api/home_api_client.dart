import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_all_category_response.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_companies.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_random_products_response.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';

part 'home_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _HomeApiClient;

  @GET(ApiEndPoints.getAllCategory)
  Future<List<GetAllCategoryResponse>> getAllCategory();

  @GET(ApiEndPoints.getCompanies)
  Future<GetCompanies> getCompanies();
  
  @GET(ApiEndPoints.getRandomProducts)
  Future<GetRandomProductsResponse> getRandomProducts({
    @Query('pageIndex') int? pageIndex,
    @Query('pageSize') int? pageSize,
    @Query('sort') String? sort,
    @Query('search') String? search,
  });
}
