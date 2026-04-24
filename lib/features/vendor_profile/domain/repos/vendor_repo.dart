import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';

abstract class VendorRepository {
  Future<ApiResult<VendorDetailsEntity>> getCompanyDetails(String id);
  Future<ApiResult<List<VendorSubcategoryEntity>>> getCompanySubcategories(String id);
  Future<ApiResult<List<VendorProductEntity>>> getProductsBySubcategory(int id);
}
