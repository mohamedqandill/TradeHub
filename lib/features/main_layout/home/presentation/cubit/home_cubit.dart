import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
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
  // final NetworkInfo _networkInfo;

  HomeCubit(
    this._getAllCategoryUseCase,
    this._getAllCompaniesUseCase,
    this._getRandomProductsUseCase,
  ) : super(const HomeState.initial()) {
    loadAllProductsLocally();
  }

  List<GetCategoryEntity> categories = [];
  List<GetCompanyEntity> companies = [];
  List<GetRandomProductEntity> allLocalProducts = [];

  Future<void> loadAllProductsLocally() async {
    var result = await _getRandomProductsUseCase(
      pageIndex: 1,
      pageSize: 100,
    );
    switch (result) {
      case Success():
        allLocalProducts = result.data?.products ?? [];
        break;
      case Error():
        break;
    }
  }

  Future<void> revokeHomeApis() async {
    await Future.wait([
      getCategories().catchError((_) {}),
      getCompanies().catchError((_) {}),
      loadAllProductsLocally().catchError((_) {}),
    ]);
    unawaited(getRandomProducts(isRefresh: true));
  }

  Future<void> getCategories() async {
    emit(state.copyWith(getCategoryState: RequestStates.loading));

    var result = await _getAllCategoryUseCase();

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

  Future<void> getRandomProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(state.copyWith(
        getRandomProductsState: RequestStates.loading,
        productsPageIndex: 1,
        productsHasReachedMax: false,
        randomProducts: [],
      ));
    } else {
      if (state.productsHasReachedMax || state.isFetchingMoreProducts) return;
      if (state.productsPageIndex > 1) {
        emit(state.copyWith(isFetchingMoreProducts: true));
      } else {
        emit(state.copyWith(getRandomProductsState: RequestStates.loading));
      }
    }

    var result = await _getRandomProductsUseCase(
      pageIndex: state.productsPageIndex,
      pageSize: 5,
    );

    switch (result) {
      case Success():
        final newProducts = result.data?.products ?? [];
        final totalCount = result.data?.count ?? 0;
        final currentPage = result.data?.pageIndex ?? state.productsPageIndex;
        final updatedProducts = isRefresh
            ? newProducts
            : [...state.randomProducts, ...newProducts];
        
        final hasReachedMax = updatedProducts.length >= totalCount || newProducts.isEmpty;

        emit(state.copyWith(
          getRandomProductsState: RequestStates.success,
          isFetchingMoreProducts: false,
          randomProducts: updatedProducts,
          productsPageIndex: currentPage + 1,
          productsHasReachedMax: hasReachedMax,
        ));

      case Error():
        emit(state.copyWith(
          getRandomProductsState: state.productsPageIndex == 1
              ? RequestStates.error
              : state.getRandomProductsState,
          isFetchingMoreProducts: false,
          errorMessage: result.error?.message,
        ));
    }
  }
}
