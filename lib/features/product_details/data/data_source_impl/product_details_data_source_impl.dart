import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import '../../../../core/api/api_executor/api_executor.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../api/product_details_api_client.dart';
import '../models/response/product_details_response_d_t_o.dart';
import '../data_source_contract/product_details_data_source_contract.dart';
import '../../../../core/api/api_constant/api_constant.dart';

@Injectable(as: ProductDetailsDataSourceContract)
class ProductDetailsDataSourceImpl extends ProductDetailsDataSourceContract {
  final ProductDetailsApiClient _apiClient;

  ProductDetailsDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<ProductDetailsResponseDTO>> getProductDetails(int id) {
    return ApiExecutor.executeApi<ProductDetailsResponseDTO>(
      apiCall: () => _apiClient.getProductDetails(id),
    );
  }

  @override
  Future<ApiResult<CartResponseDTO>> addToCart(int productId, {int quantity = 1}) {
    return ApiExecutor.executeApi<CartResponseDTO>(
      apiCall: () => _apiClient.addToCart({
        ApiConstants.productId: productId,
        ApiConstants.quantity: quantity,
      }),
    );
  }
  

  @override
  Future<ApiResult<void>> toggleFavorite(int productId) {
    return ApiExecutor.executeApi<void>(
      apiCall: () => _apiClient.toggleFavorite(productId),
    );
  }
}
