import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/data/api/vendor_api_client.dart';
import 'package:tradehub/features/vendor_profile/data/models/vendor_models.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

abstract class VendorDataSource {
  Future<ApiResult<VendorDetailsModel>> getCompanyDetails(String id);
  Future<ApiResult<List<VendorSubcategoryModel>>> getCompanySubcategories(String id);
  Future<ApiResult<List<VendorProductModel>>> getProductsBySubcategory(int id);
  Future<ApiResult<List<ProductRatingDTO>>> getCompanyRatings(String companyId);
  Future<ApiResult<ProductRatingDTO>> addCompanyRating({
    required String companyId,
    required int ratingValue,
    required String comment,
  });
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

  @override
  Future<ApiResult<List<ProductRatingDTO>>> getCompanyRatings(String companyId) {
    return ApiExecutor.executeApi(apiCall: () => _apiClient.getCompanyRatings(companyId));
  }

  @override
  Future<ApiResult<ProductRatingDTO>> addCompanyRating({
    required String companyId,
    required int ratingValue,
    required String comment,
  }) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.addCompanyRating(companyId, {
        ApiConstants.ratingValue: ratingValue,
        ApiConstants.comment: comment,
      }),
    );
  }
}
