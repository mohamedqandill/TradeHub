import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';
import 'package:tradehub/main.dart';

import '../../../../../core/api/api_result/api_result.dart';
import '../../domain/entites/favourite_product_entity.dart';
import '../../domain/use_cases/get_favorites_use_case.dart';
import '../../domain/use_cases/toggle_favorite_use_case.dart';

part 'favourite_cubit.freezed.dart';
part 'favourite_state.dart';

@injectable
class FavouriteCubit extends Cubit<FavouriteState> {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  FavouriteCubit(
    this._getFavoritesUseCase,
    this._toggleFavoriteUseCase,
  ) : super(const FavouriteState.initial());

  List<FavoriteProductEntity> favorites = [];
  List<int?> favoritesIds = [];

  void setFavorites(List<int?> ids) {
    favoritesIds = List.from(ids);
    emit(state.copyWith(favoritesUpdate: RequestStates.success));
  }

  Future<void> getFavorites() async {
    emit(state.copyWith(getFavoritesState: RequestStates.loading));

    var result = await _getFavoritesUseCase();

    switch (result) {
      case Success():
        favorites = result.data ?? [];
        emit(state.copyWith(getFavoritesState: RequestStates.success));
      case Error():
        emit(state.copyWith(
          getFavoritesState: RequestStates.error,
          errorMessage: result.error?.message,
        ));
    }
  }

  Future<void> toggleFavorite(int id) async {
    if (favoritesIds.contains(id)) {
      favoritesIds.remove(id);
      favorites = favorites.where((element) => element.id != id).toList();
    } else {
      favoritesIds.add(id);
    }
   

   

    emit(state.copyWith(
      toggleFavoriteState: RequestStates.loading,
       favoritesUpdate: RequestStates.success,
    ));
    var result = await _toggleFavoriteUseCase(id);

    switch (result) {
      case Success():
        emit(state.copyWith(toggleFavoriteState: RequestStates.success));
        getIt<SharedProductRepository>().markUpdated();
        getIt<SharedProductRepository>().markThatFavoriteChange();
      case Error():
       if (favoritesIds.contains(id)) {
        favoritesIds.remove(id);
      } else {
        favoritesIds.add(id);
      }
        emit(state.copyWith(
          toggleFavoriteState: RequestStates.error,
          errorMessage: result.error?.message,
        ));
    }
  }

  void initFavorites(List<GetRandomProductEntity> products) {
    for (var product in products) {
      if (product.isFavourite == true) {
        favoritesIds.add(product.id ?? 0);
      }
    }
  }
}
