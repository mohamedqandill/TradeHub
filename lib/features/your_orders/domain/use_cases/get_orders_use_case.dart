import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../repo_contract/orders_repository.dart';
import '../../data/models/order_response_d_t_o.dart';

@injectable
class GetOrdersUseCase {
  final OrdersRepository _repository;

  GetOrdersUseCase(this._repository);

  Future<ApiResult<OrderResponseDTO>> call({
    String? orderStatus,
    int? pageIndex,
    int? pageSize,
  }) async {
    return await _repository.getOrders(
      orderStatus: orderStatus,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );
  }
}
