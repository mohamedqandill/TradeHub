import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';
import 'package:tradehub/features/vendor_profile/domain/use_cases/vendor_use_cases.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_states.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

@injectable
class VendorProfileCubit extends Cubit<VendorProfileStates> {
  final GetVendorDetailsUseCase _getVendorDetailsUseCase;
  final GetVendorSubcategoriesUseCase _getVendorSubcategoriesUseCase;
  final GetProductsBySubcategoryUseCase _getProductsBySubcategoryUseCase;
  final GetCompanyRatingsUseCase _getCompanyRatingsUseCase;
  final AddCompanyRatingUseCase _addCompanyRatingUseCase;

  VendorProfileCubit(
    this._getVendorDetailsUseCase,
    this._getVendorSubcategoriesUseCase,
    this._getProductsBySubcategoryUseCase,
    this._getCompanyRatingsUseCase,
    this._addCompanyRatingUseCase,
  ) : super(VendorProfileInitialState());
  
  VendorDetailsEntity? vendorDetails;
  List<VendorSubcategoryEntity> subcategories = [];

  List<VendorProductEntity> products = [];
  int? subCategoryId;

  List<ProductRatingDTO> companyRatings = [];

  void getVendorDetails(String id) async {
    emit(GetVendorDetailsLoadingState());
    final result = await _getVendorDetailsUseCase(id);
    switch (result) {
      case Success():
        vendorDetails = result.data;
        emit(GetVendorDetailsSuccessState());

        break;
      case Error():
        emit(GetVendorDetailsErrorState(
            result.error?.message ?? "An error occurred"));
        break;
    }
  }

  void getCompanyRatings(String companyId) async {
    emit(GetCompanyRatingsLoadingState());
    final result = await _getCompanyRatingsUseCase(companyId);
    switch (result) {
      case Success():
        companyRatings = result.data ?? [];
        emit(GetCompanyRatingsSuccessState());
        break;
      case Error():
        emit(GetCompanyRatingsErrorState(
            result.error?.message ?? "An error occurred"));
        break;
    }
  }

  Future<void> addCompanyRating({
    required String companyId,
    required int ratingValue,
    required String comment,
  }) async {
    emit(AddCompanyRatingLoadingState());
    final result = await _addCompanyRatingUseCase(
      companyId: companyId,
      ratingValue: ratingValue,
      comment: comment,
    );
    switch (result) {
      case Success():
        getCompanyRatings(companyId);
        emit(AddCompanyRatingSuccessState());
        break;
      case Error():
        emit(AddCompanyRatingErrorState(
            result.error?.message ?? "An error occurred"));
        break;
    }
  }

  void getVendorSubcategories(String id) async {
    emit(GetVendorSubcategoriesLoadingState());
    final result = await _getVendorSubcategoriesUseCase(id);
    switch (result) {
      case Success():
        subcategories = result.data ?? [];
        if (subcategories.isNotEmpty) {
          subCategoryId = subcategories.first.id;
        }
        getProductsBySubcategory(subCategoryId!);
        emit(GetVendorSubcategoriesSuccessState());

        break;
      case Error():
        emit(GetVendorSubcategoriesErrorState(
            result.error?.message ?? "An error occurred"));
        break;
    }
  }

  void getProductsBySubcategory(int id) async {
    subCategoryId = id;
    emit(GetProductsBySubcategoryLoadingState());
    final result = await _getProductsBySubcategoryUseCase(id);
    switch (result) {
      case Success():
        products = result.data ?? [];
        emit(GetProductsBySubcategorySuccessState());
        break;
      case Error():
        emit(GetProductsBySubcategoryErrorState(
            result.error?.message ?? "An error occurred"));
        break;
    }
  }
}
