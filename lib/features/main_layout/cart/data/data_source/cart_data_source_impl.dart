import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/cart/data/models/update_item_quantity_body.dart';
import '../../../../../core/api/api_executor/api_executor.dart';
import '../../../../../core/api/api_result/api_result.dart';
import '../api/cart_api_client.dart';
import '../models/cart_response_d_t_o.dart';
import 'cart_data_source_contract.dart';

@Injectable(as: CartDataSourceContract)
class CartDataSourceImpl extends CartDataSourceContract {
  final CartApiClient _apiClient;

  CartDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<CartResponseDTO>> getBasket() {
    return ApiExecutor.executeApi<CartResponseDTO>(
      apiCall: () => _apiClient.getBasket(),
    );
  }

  @override
  Future<ApiResult<void>> removeBasket() {
    return ApiExecutor.executeApi<void>(
      apiCall: () => _apiClient.removeBasket(),
    );
  }

  @override
  Future<ApiResult<void>> removeItem(int id) {
    return ApiExecutor.executeApi<void>(
      apiCall: () => _apiClient.removeItem(id),
    );
  }

  @override
  Future<ApiResult<void>> updateItemQuantity(int id) {
    return ApiExecutor.executeApi<void>(
      apiCall: () => _apiClient.updateItemQuantity(id),
    );
  }
}
