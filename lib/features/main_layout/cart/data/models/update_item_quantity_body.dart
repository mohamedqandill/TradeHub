import 'package:tradehub/core/api/api_constant/api_constant.dart';

class AddItemToCartBody {
 final int productId;
 final int quantity;

 AddItemToCartBody({required this.productId, required this.quantity});

 Map<String, dynamic> toJson() => {
 ApiConstants.productId: productId,
 ApiConstants.quantity: quantity,
 };

}
