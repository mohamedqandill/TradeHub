part of 'category_details_cubit.dart';

@freezed
class CategoryDetailsState with _$CategoryDetailsState {
  const factory CategoryDetailsState({
    @Default(RequestStates.initial) RequestStates getCompaniesState,
    String? errorMessage,
  }) = _Initial;
}
