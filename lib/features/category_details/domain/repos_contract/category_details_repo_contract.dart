import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';

abstract class CategoryDetailsRepoContract {
  Future<ApiResult<List<CategoryCompanyEntity>>> getCompaniesByCategory(int categoryId);
}

