import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../data/models/request/checkout_request_d_t_o.dart';
import '../../data/models/response/checkout_response_d_t_o.dart';
import '../repo_contract/checkout_repository.dart';

@injectable
class CheckoutUseCase {
  final CheckoutRepository _repository;

  CheckoutUseCase(this._repository);

  Future<ApiResult<CheckoutResponseDTO>> call({required CheckoutRequestDTO body}) {
    return _repository.checkout(body: body);
  }
}
