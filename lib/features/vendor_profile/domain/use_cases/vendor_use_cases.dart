import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';
import 'package:tradehub/features/vendor_profile/domain/repos/vendor_repo.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

@injectable
class GetVendorDetailsUseCase {
  final VendorRepository _repo;
  GetVendorDetailsUseCase(this._repo);

  Future<ApiResult<VendorDetailsEntity>> call(String id) => _repo.getCompanyDetails(id);
}

@injectable
class GetVendorSubcategoriesUseCase {
  final VendorRepository _repo;
  GetVendorSubcategoriesUseCase(this._repo);

  Future<ApiResult<List<VendorSubcategoryEntity>>> call(String id) => _repo.getCompanySubcategories(id);
}

@injectable
class GetProductsBySubcategoryUseCase {
  final VendorRepository _repo;
  GetProductsBySubcategoryUseCase(this._repo);

  Future<ApiResult<List<VendorProductEntity>>> call(int id) => _repo.getProductsBySubcategory(id);
}

@injectable
class GetCompanyRatingsUseCase {
  final VendorRepository _repo;
  GetCompanyRatingsUseCase(this._repo);

  Future<ApiResult<List<ProductRatingDTO>>> call(String companyId) =>
      _repo.getCompanyRatings(companyId);
}

@injectable
class AddCompanyRatingUseCase {
  final VendorRepository _repo;
  AddCompanyRatingUseCase(this._repo);

  Future<ApiResult<ProductRatingDTO>> call({
    required String companyId,
    required int ratingValue,
    required String comment,
  }) =>
      _repo.addCompanyRating(
        companyId: companyId,
        ratingValue: ratingValue,
        comment: comment,
      );
}
