import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';
import 'package:tradehub/features/order_details/domain/repositories/order_details_repository.dart';

@injectable
class GetOrderDetailsUseCase {
  final OrderDetailsRepository _repository;

  GetOrderDetailsUseCase(this._repository);

  Future<ApiResult<OrderDetailsResponseDTO>> execute(int id) {
    return _repository.getOrderDetails(id);
  }
}
