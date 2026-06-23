import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/data/data_sources/vendor_data_source.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';
import 'package:tradehub/features/vendor_profile/domain/repos/vendor_repo.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

@Injectable(as: VendorRepository)
class VendorRepositoryImpl implements VendorRepository {
  final VendorDataSource _dataSource;

  VendorRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<VendorDetailsEntity>> getCompanyDetails(String id) async {
    final result = await _dataSource.getCompanyDetails(id);
    switch (result) {
      case Success():
        return Success(data: result.data?.toEntity());
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<List<VendorSubcategoryEntity>>> getCompanySubcategories(
      String id) async {
    final result = await _dataSource.getCompanySubcategories(id);
    switch (result) {
      case Success():
        return Success(data: result.data?.map((e) => e.toEntity()).toList());
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<List<VendorProductEntity>>> getProductsBySubcategory(
      int id) async {
    final result = await _dataSource.getProductsBySubcategory(id);
    switch (result) {
      case Success():
        return Success(data: result.data?.map((e) => e.toEntity()).toList());
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<List<ProductRatingDTO>>> getCompanyRatings(
      String companyId) async {
    return _dataSource.getCompanyRatings(companyId);
  }

  @override
  Future<ApiResult<ProductRatingDTO>> addCompanyRating({
    required String companyId,
    required int ratingValue,
    required String comment,
  }) async {
    return _dataSource.addCompanyRating(
      companyId: companyId,
      ratingValue: ratingValue,
      comment: comment,
    );
  }
}
