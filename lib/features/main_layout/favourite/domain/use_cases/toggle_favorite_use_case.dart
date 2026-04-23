import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_result/api_result.dart';
import '../repos_contract/favourite_repo_contract.dart';

@injectable
class ToggleFavoriteUseCase {
  final FavouriteRepoContract _repo;

  ToggleFavoriteUseCase(this._repo);

  Future<ApiResult<void>> call(int id) async {
    return await _repo.toggleFavorite(id);
  }
}
