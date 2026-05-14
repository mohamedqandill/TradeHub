import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/your_orders/domain/repo_contract/orders_repository.dart';
import '../../data/data_source_contract/orders_data_source.dart';
import '../../data/models/order_response_d_t_o.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersDataSource _dataSource;

  OrdersRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<OrderResponseDTO>>> getOrders() async {
    return await _dataSource.getOrders();
  }
}
