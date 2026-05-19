import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/data/data_source/home_data_source.dart';
import 'package:tradehub/features/main_layout/home/data/data_source/home_local_data_source.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_category_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_company_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_products_response_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/repos_contract/home_repo_contract.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract {
  final HomeDataSource _homeDataSource;
  final HomeLocalDataSource _homeLocalDataSource;

  HomeRepoImpl(
    this._homeDataSource,
    this._homeLocalDataSource,
  );

  @override
  Future<ApiResult<List<GetCategoryEntity>>> getCategory() async {
    var result = await _homeDataSource.getCategory();

    switch (result) {
      case Success():
        if (result.data != null) {
          await _homeLocalDataSource.cacheCategories(result.data!);
          return Success(
              data: result.data!
                  .map((e) => e.toEntity() as GetCategoryEntity)
                  .toList());
        }
        return Success(data: []);
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<List<GetCompanyEntity>>> getCompanies() async {
    var result = await _homeDataSource.getCompanies();

    switch (result) {
      case Success():
        if (result.data != null) {
          return Success(
              data: result.data!.data
                  .map((e) => e.toEntity() as GetCompanyEntity)
                  .toList());
        }
        return Success(data: []);
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<GetRandomProductsResponseEntity>> getRandomProducts({int? pageIndex, int? pageSize}) async {
    var result = await _homeDataSource.getRandomProducts(pageIndex: pageIndex, pageSize: pageSize);

    switch (result) {
      case Success():
        if (result.data != null) {
          return Success(
              data: GetRandomProductsResponseEntity(
            pageIndex: result.data!.pageIndex,
            pageSize: result.data!.pageSize,
            count: result.data!.count,
            products: result.data!.data
                .map((e) => e.toEntity() as GetRandomProductEntity)
                .toList(),
          ));
        }
        return Success(
          data: const GetRandomProductsResponseEntity(
            pageIndex: 0,
            pageSize: 0,
            count: 0,
            products: [],
          ),
        );
      case Error():
        return Error(error: result.error);
    }
  }
}
