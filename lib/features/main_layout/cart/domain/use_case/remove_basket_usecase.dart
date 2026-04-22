import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../repo_contract/cart_repo_contract.dart';

@injectable
class RemoveBasketUseCase {
  final CartRepoContract _repo;

  RemoveBasketUseCase(this._repo);

  Future<ApiResult<void>> call() {
    return _repo.removeBasket();
  }
}
