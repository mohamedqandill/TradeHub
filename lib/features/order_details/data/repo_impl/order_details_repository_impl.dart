import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/order_details/data/data_source_contract/order_details_remote_data_source.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';
import 'package:tradehub/features/order_details/domain/repositories/order_details_repository.dart';

@Injectable(as: OrderDetailsRepository)
class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsRemoteDataSource _remoteDataSource;

  OrderDetailsRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<OrderDetailsResponseDTO>> getOrderDetails(int id) {
    return _remoteDataSource.getOrderDetails(id);
  }
  @override
  Future<ApiResult<void>> cancelOrder({required int id}) {
    return _remoteDataSource.cancelOrder(id: id);
  }
}
