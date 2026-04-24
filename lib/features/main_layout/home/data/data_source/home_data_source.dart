import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/data/api/home_api_client.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_all_category_response.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_companies.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_random_products_d_t_o.dart';

abstract class HomeDataSource {
  Future<ApiResult<List<GetAllCategoryResponse>>> getCategory();
  Future<ApiResult<GetCompanies>> getCompanies();
  Future<ApiResult<List<GetRandomProductsDTO>>> getRandomProducts();
}

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final HomeApiClient _homeApiClient;

  HomeDataSourceImpl(this._homeApiClient);

  @override
  Future<ApiResult<List<GetAllCategoryResponse>>> getCategory() async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _homeApiClient.getAllCategory(),
    );
    switch (result) {
      case Success():
        return Success(data: result.data);
      case Error<List<GetAllCategoryResponse>>():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<GetCompanies>> getCompanies() async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _homeApiClient.getCompanies(),
    );
    switch (result) {
      case Success():
        return Success(data: result.data);
      case Error<GetCompanies>():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<List<GetRandomProductsDTO>>> getRandomProducts() async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _homeApiClient.getRandomProducts(),
    );
    switch (result) {
      case Success():
        return Success(data: result.data);
      case Error<List<GetRandomProductsDTO>>():
        return Error(error: result.error);
    }
  }
}
