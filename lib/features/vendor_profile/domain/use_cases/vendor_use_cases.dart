import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';
import 'package:tradehub/features/vendor_profile/domain/repos/vendor_repo.dart';

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
