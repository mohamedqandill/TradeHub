import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../repo_contract/cart_repo_contract.dart';

@injectable
class RemoveItemUseCase {
  final CartRepoContract _repo;

  RemoveItemUseCase(this._repo);

  Future<ApiResult<void>> call(int id) {
    return _repo.removeItem(id);
  }
}
