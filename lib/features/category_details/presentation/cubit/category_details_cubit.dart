import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';
import 'package:tradehub/features/category_details/domain/use_cases/get_companies_by_category_usecase.dart';
import 'package:tradehub/main.dart';

part 'category_details_cubit.freezed.dart';
part 'category_details_state.dart';

@injectable
class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final GetCompaniesByCategoryUseCase _getCompaniesByCategoryUseCase;

  CategoryDetailsCubit(this._getCompaniesByCategoryUseCase)
      : super(const CategoryDetailsState());

  List<CategoryCompanyEntity> companies = [];

  Future<void> getCompaniesByCategory(int categoryId) async {
    emit(state.copyWith(getCompaniesState: RequestStates.loading));

    final result = await _getCompaniesByCategoryUseCase(categoryId);

    switch (result) {
      case Success():
        companies = result.data ?? [];
        emit(state.copyWith(getCompaniesState: RequestStates.success));
      case Error():
        emit(state.copyWith(
          getCompaniesState: RequestStates.error,
          errorMessage: result.error?.message,
        ));
    }
  }
}
