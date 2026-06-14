import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../../domain/use_cases/add_to_cart_usecase.dart';
import '../../domain/use_cases/get_product_details_usecase.dart';
import '../../domain/use_cases/get_product_options_usecase.dart';
import '../../../main_layout/favourite/domain/use_cases/toggle_favorite_use_case.dart';
import '../../data/models/response/product_details_response_d_t_o.dart';
import '../../data/models/response/product_option_response_dto.dart';
import 'product_details_states.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final GetProductOptionsUseCase _getProductOptionsUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final SharedProductRepository repo;

  ProductDetailsCubit(
    this.repo,
    this._getProductDetailsUseCase,
    this._getProductOptionsUseCase,
    this._toggleFavoriteUseCase,
  ) : super(ProductDetailsInitialState());

List<int> selectedOptionValueIds = [];
  ProductDetailsResponseDTO? productDetails;
  List<ProductOptionDTO>? productOptions;

  Future<void> getProductDetails(int id) async {
    emit(GetProductDetailsLoadingState());
    var results = await Future.wait([
      _getProductDetailsUseCase(id),
      _getProductOptionsUseCase(id),
    ]);

    var detailsResult = results[0] as ApiResult<ProductDetailsResponseDTO>;
    var optionsResult = results[1] as ApiResult<List<ProductOptionDTO>>;

    if (detailsResult is Success<ProductDetailsResponseDTO> &&
        optionsResult is Success<List<ProductOptionDTO>>) {
      productDetails = detailsResult.data;
      productOptions = optionsResult.data;
      emit(GetProductDetailsSuccessState());
    } else {
      String errorMessage = "Error occurred";
      if (detailsResult is Error<ProductDetailsResponseDTO>) {
        errorMessage = detailsResult.error?.message ?? errorMessage;
      } else if (optionsResult is Error<List<ProductOptionDTO>>) {
        errorMessage = optionsResult.error?.message ?? errorMessage;
      }
      emit(GetProductDetailsErrorState(errorMessage));
    }
  }


  Future<void> toggleFavorite(int productId) async {
    emit(ToggleFavoriteLoadingState());
    var result = await _toggleFavoriteUseCase(productId);
    if (result is Success<void>) {
      repo.markUpdated();
      repo.markThatFavoriteChange();
      emit(ToggleFavoriteSuccessState());
    } else if (result is Error<void>) {
      emit(ToggleFavoriteErrorState(result.error?.message ?? "Error occurred"));
    }
  }
}
