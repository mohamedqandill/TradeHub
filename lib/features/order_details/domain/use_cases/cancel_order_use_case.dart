

import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/order_details/domain/repositories/order_details_repository.dart';

@injectable
class CancelOrderUseCase {
  final OrderDetailsRepository _repository;

  CancelOrderUseCase(this._repository);

  Future<ApiResult<void>> call({required int id}) async {
    return await _repository.cancelOrder(id: id);
  }
}
