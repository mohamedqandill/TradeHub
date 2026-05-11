import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/cart/data/models/update_item_quantity_body.dart';
import '../../../../../core/api/api_result/api_result.dart';
import '../../../cart/data/data_source/cart_data_source_contract.dart';
import '../../../cart/data/models/cart_response_d_t_o.dart';
import '../../../cart/domain/repo_contract/cart_repo_contract.dart';

@Injectable(as: CartRepoContract)
class CartRepoImpl extends CartRepoContract {
  final CartDataSourceContract _dataSource;

  CartRepoImpl(this._dataSource);

  @override
  Future<ApiResult<List<CartResponseDTO>>> getBasket() {
    return _dataSource.getBasket();
  }


  @override
  Future<ApiResult<void>> removeBasket() {
    return _dataSource.removeBasket();
  }

  @override
  Future<ApiResult<void>> removeItem({required int companyId, required int productId}) {
    return _dataSource.removeItem(companyId: companyId, productId: productId);
  }

  @override
  Future<ApiResult<void>> updateItemQuantity({required int companyId, required int productId, required int quantity}) {
    return _dataSource.updateItemQuantity(companyId: companyId, productId: productId, quantity: quantity);
  }
}
