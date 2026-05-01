part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(RequestStates.initial) RequestStates getCategoryState,
    @Default(RequestStates.initial) RequestStates getCompaniesState,
    @Default(RequestStates.initial) RequestStates getRandomProductsState,
    @Default([]) List<GetRandomProductEntity> randomProducts,
    String? errorMessage,
  }) = _Initial;
}
