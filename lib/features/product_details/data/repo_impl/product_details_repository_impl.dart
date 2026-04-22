import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../../domain/repo_contract/product_details_repository_contract.dart';
import '../data_source_contract/product_details_data_source_contract.dart';
import '../models/response/product_details_response_d_t_o.dart';

@Injectable(as: ProductDetailsRepositoryContract)
class ProductDetailsRepositoryImpl extends ProductDetailsRepositoryContract {
  final ProductDetailsDataSourceContract _dataSource;

  ProductDetailsRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<ProductDetailsResponseDTO>> getProductDetails(int id) {
    return _dataSource.getProductDetails(id);
  }

  @override
  Future<ApiResult<CartResponseDTO>> addToCart(int productId, {int quantity = 1}) {
    return _dataSource.addToCart(productId, quantity: quantity);
  }

  @override
  Future<ApiResult<void>> toggleFavorite(int productId) {
    return _dataSource.toggleFavorite(productId);
  }
}
