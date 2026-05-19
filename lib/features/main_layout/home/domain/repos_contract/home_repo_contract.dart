import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_category_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_company_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_products_response_entity.dart';

abstract class HomeRepoContract {
  Future<ApiResult<List<GetCategoryEntity>>> getCategory();
  Future<ApiResult<List<GetCompanyEntity>>> getCompanies();
  Future<ApiResult<GetRandomProductsResponseEntity>> getRandomProducts({int? pageIndex, int? pageSize});
}
