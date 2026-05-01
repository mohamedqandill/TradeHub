import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../../domain/use_cases/add_to_cart_usecase.dart';
import '../../domain/use_cases/get_product_details_usecase.dart';
import '../../../main_layout/favourite/domain/use_cases/toggle_favorite_use_case.dart';
import '../../data/models/response/product_details_response_d_t_o.dart';
import 'product_details_states.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final SharedProductRepository repo;

  ProductDetailsCubit(
    this.repo,
    this._getProductDetailsUseCase,
    this._toggleFavoriteUseCase,
  ) : super(ProductDetailsInitialState());

  ProductDetailsResponseDTO? productDetails;

  Future<void> getProductDetails(int id) async {
    emit(GetProductDetailsLoadingState());
    var result = await _getProductDetailsUseCase(id);
    if (result is Success<ProductDetailsResponseDTO>) {
      productDetails = result.data;

      emit(GetProductDetailsSuccessState());
    } else if (result is Error<ProductDetailsResponseDTO>) {
      emit(GetProductDetailsErrorState(
          result.error?.message ?? "Error occurred"));
    }
  }

  Future<void> toggleFavorite(int productId) async {
    emit(ToggleFavoriteLoadingState());
    var result = await _toggleFavoriteUseCase(productId);
    if (result is Success<void>) {
      repo.markUpdated();
      emit(ToggleFavoriteSuccessState());
    } else if (result is Error<void>) {
      emit(ToggleFavoriteErrorState(result.error?.message ?? "Error occurred"));
    }
  }
}
