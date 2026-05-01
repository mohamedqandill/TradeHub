import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/category_details/data/data_source/category_details_data_source.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';
import 'package:tradehub/features/category_details/domain/repos_contract/category_details_repo_contract.dart';

@Injectable(as: CategoryDetailsRepoContract)
class CategoryDetailsRepoImpl implements CategoryDetailsRepoContract {
  final CategoryDetailsDataSource _dataSource;

  CategoryDetailsRepoImpl(this._dataSource);

  @override
  Future<ApiResult<List<CategoryCompanyEntity>>> getCompaniesByCategory(
      int categoryId) async {
    final result = await _dataSource.getCompaniesByCategory(categoryId);

    switch (result) {
      case Success():
        return Success(
          data: (result.data ?? []).map((e) => e.toEntity()).toList(),
        );
      case Error():
        return Error(error: result.error);
    }
  }
}

