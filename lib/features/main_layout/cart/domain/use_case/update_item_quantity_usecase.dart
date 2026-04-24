import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../repo_contract/cart_repo_contract.dart';

@injectable
class UpdateItemQuantityUseCase {
  final CartRepoContract _repo;

  UpdateItemQuantityUseCase(this._repo);

  Future<ApiResult<void>> call({required int id, required int quantity}) {
    return _repo.updateItemQuantity(id: id, quantity: quantity);
  }
}