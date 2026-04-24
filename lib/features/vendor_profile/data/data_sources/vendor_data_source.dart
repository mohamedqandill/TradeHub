import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/data/api/vendor_api_client.dart';
import 'package:tradehub/features/vendor_profile/data/models/vendor_models.dart';

abstract class VendorDataSource {
  Future<ApiResult<VendorDetailsModel>> getCompanyDetails(String id);
  Future<ApiResult<List<VendorSubcategoryModel>>> getCompanySubcategories(String id);
  Future<ApiResult<List<VendorProductModel>>> getProductsBySubcategory(int id);
}

@Injectable(as: VendorDataSource)
class VendorDataSourceImpl implements VendorDataSource {
  final VendorApiClient _apiClient;

  VendorDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<VendorDetailsModel>> getCompanyDetails(String id) {
    return ApiExecutor.executeApi(apiCall: () => _apiClient.getCompanyDetails(id));
  }

  @override
  Future<ApiResult<List<VendorSubcategoryModel>>> getCompanySubcategories(String id) {
    return ApiExecutor.executeApi(apiCall: () => _apiClient.getCompanySubcategories(id));
  }

  @override
  Future<ApiResult<List<VendorProductModel>>> getProductsBySubcategory(int id) {
    return ApiExecutor.executeApi(apiCall: () => _apiClient.getProductsBySubcategory(id));
  }
}
