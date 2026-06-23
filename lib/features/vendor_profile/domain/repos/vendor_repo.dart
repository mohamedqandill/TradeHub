import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

abstract class VendorRepository {
  Future<ApiResult<VendorDetailsEntity>> getCompanyDetails(String id);
  Future<ApiResult<List<VendorSubcategoryEntity>>> getCompanySubcategories(String id);
  Future<ApiResult<List<VendorProductEntity>>> getProductsBySubcategory(int id);
  Future<ApiResult<List<ProductRatingDTO>>> getCompanyRatings(String companyId);
  Future<ApiResult<ProductRatingDTO>> addCompanyRating({
    required String companyId,
    required int ratingValue,
    required String comment,
  });
}
