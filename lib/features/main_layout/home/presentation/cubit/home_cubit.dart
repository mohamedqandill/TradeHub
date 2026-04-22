import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/core/utils/network/network_info.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_category_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_company_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/use_cases/get_all_category_usecase.dart';
import 'package:tradehub/features/main_layout/home/domain/use_cases/get_all_companies_usecase.dart';
import 'package:tradehub/features/main_layout/home/domain/use_cases/get_random_products_usecase.dart';
import 'package:tradehub/main.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllCategoryUseCase _getAllCategoryUseCase;
  final GetAllCompaniesUseCase _getAllCompaniesUseCase;
  final GetRandomProductsUseCase _getRandomProductsUseCase;
  bool isHomeLoaded = false;
  // final NetworkInfo _networkInfo;

  HomeCubit(
    this._getAllCategoryUseCase,
    this._getAllCompaniesUseCase,
    this._getRandomProductsUseCase,
  ) : super(const HomeState.initial());

  List<GetCategoryEntity> categories = [];
  List<GetCompanyEntity> companies = [];
  List<GetRandomProductEntity> randomProducts = [];

  Future<void> revokeHomeApis() async {
    if (!isHomeLoaded) {
      await Future.wait([
        getCategories().catchError((_) {}),
        getCompanies().catchError((_) {}),
        getRandomProducts().catchError((_) {}),
      ]);
      isHomeLoaded = true;
    }
  }

  Future<void> getCategories() async {
    emit(state.copyWith(getCategoryState: RequestStates.loading));

    var result = await _getAllCategoryUseCase.call();

    switch (result) {
      case Success():
        categories = result.data ?? [];
        emit(state.copyWith(getCategoryState: RequestStates.success));
      case Error():
        emit(state.copyWith(
            getCategoryState: RequestStates.error,
            errorMessage: result.error?.message));
    }
  }

  Future<void> getCompanies() async {
    emit(state.copyWith(getCompaniesState: RequestStates.loading));

    var result = await _getAllCompaniesUseCase.call();

    switch (result) {
      case Success():
        companies = result.data ?? [];
        emit(state.copyWith(getCompaniesState: RequestStates.success));
      case Error():
        emit(state.copyWith(
            getCompaniesState: RequestStates.error,
            errorMessage: result.error?.message));
    }
  }

  Future<void> getRandomProducts() async {
    emit(state.copyWith(getRandomProductsState: RequestStates.loading));

    var result = await _getRandomProductsUseCase.call();

    switch (result) {
      case Success():
        randomProducts = result.data ?? [];
        emit(state.copyWith(getRandomProductsState: RequestStates.success));
      case Error():
        emit(state.copyWith(
            getRandomProductsState: RequestStates.error,
            errorMessage: result.error?.message));
    }
  }
}
