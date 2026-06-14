part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(RequestStates.initial) RequestStates getCategoryState,
    @Default(RequestStates.initial) RequestStates getCompaniesState,
    @Default(RequestStates.initial) RequestStates getRandomProductsState,
    @Default([]) List<GetRandomProductEntity> randomProducts,
    @Default(1) int productsPageIndex,
    @Default(false) bool productsHasReachedMax,
    @Default(false) bool isFetchingMoreProducts,
    String? productsSort,
    String? errorMessage,
  }) = _Initial;
}
