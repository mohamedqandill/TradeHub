import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'cart_response_d_t_o.g.dart';

@JsonSerializable()
class CartResponseDTO {
  @JsonKey(name: ApiConstants.id)
  final int id;
  @JsonKey(name: ApiConstants.buyerId)
  final String buyerId;
  @JsonKey(name: ApiConstants.companyName)
  final String companyName;
  @JsonKey(name: ApiConstants.companyId)
  final String companyId;
  @JsonKey(name: ApiConstants.items)
  final List<Items> items;
  @JsonKey(name: ApiConstants.logoUrl)
  final String? logoUrl;
  @JsonKey(name: ApiConstants.subTotal, defaultValue: 0)
  final int subTotal;

  const CartResponseDTO({
    required this.id,
    required this.buyerId,
    required this.companyName,
    required this.companyId,
    required this.items,
    required this.subTotal,
      required this.logoUrl,
  });

  factory CartResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CartResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseDTOToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: ApiConstants.id)
  final int id;
  @JsonKey(name: ApiConstants.productId)
  final int productId;
  @JsonKey(name: ApiConstants.productName)
  final String productName;
  @JsonKey(name: ApiConstants.pictureUrl)
  final String pictureUrl;
  @JsonKey(name: ApiConstants.price)
  final int price;
  @JsonKey(name: ApiConstants.quantity)
  final int quantity;
  @JsonKey(name: ApiConstants.total)
  final int total;
  @JsonKey(name: ApiConstants.options)
  final List<CartOptionDTO>? options;

  const Items({
    required this.id,
    required this.productId,
    required this.productName,
    required this.pictureUrl,
    required this.price,
    required this.quantity,
    required this.total,
    this.options,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class CartOptionDTO {
  @JsonKey(name: ApiConstants.productOptionValueId)
  final int? productOptionValueId;
  @JsonKey(name: ApiConstants.optionName)
  final String? optionName;
  @JsonKey(name: ApiConstants.valueName)
  final String? valueName;
  @JsonKey(name: ApiConstants.extraPrice)
  final int? extraPrice;

  const CartOptionDTO({
    required this.productOptionValueId,
    required this.optionName,
    required this.valueName,
    required this.extraPrice,
  });

  factory CartOptionDTO.fromJson(Map<String, dynamic> json) =>
      _$CartOptionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CartOptionDTOToJson(this);
}


