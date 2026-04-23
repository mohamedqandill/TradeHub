part of 'favourite_cubit.dart';

@freezed
class FavouriteState with _$FavouriteState {
  const factory FavouriteState.initial({
    @Default(RequestStates.initial) RequestStates getFavoritesState,
    @Default(RequestStates.initial) RequestStates toggleFavoriteState,

    
    String? errorMessage,
  }) = _Initial;
}
