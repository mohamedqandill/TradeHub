import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../data/models/cart_response_d_t_o.dart';
import '../repo_contract/cart_repo_contract.dart';

@injectable
class GetBasketUseCase {
  final CartRepoContract _repo;

  GetBasketUseCase(this._repo);

  Future<ApiResult<List<CartResponseDTO>>> call() {
    return _repo.getBasket();
  }
}

