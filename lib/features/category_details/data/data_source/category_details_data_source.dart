import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/category_details/data/api/category_details_api_client.dart';
import 'package:tradehub/features/category_details/data/models/category_company_dto.dart';

abstract class CategoryDetailsDataSource {
  Future<ApiResult<List<CategoryCompanyDTO>>> getCompaniesByCategory(int categoryId);
}

@Injectable(as: CategoryDetailsDataSource)
class CategoryDetailsDataSourceImpl implements CategoryDetailsDataSource {
  final CategoryDetailsApiClient _apiClient;

  CategoryDetailsDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<List<CategoryCompanyDTO>>> getCompaniesByCategory(int categoryId) {
    return ApiExecutor.executeApi<List<CategoryCompanyDTO>>(
      apiCall: () => _apiClient.getCompaniesByCategory(categoryId),
    );
  }
}

