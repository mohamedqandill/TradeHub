import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'order_details_response_d_t_o.g.dart';

@JsonSerializable()
class OrderDetailsResponseDTO {
  @JsonKey(name: ApiConstants.id)
  final int id;
  @JsonKey(name: ApiConstants.subTotal)
  final double subTotal;
  @JsonKey(name: ApiConstants.deliveryFee)
  final double deliveryFee;
  @JsonKey(name: ApiConstants.total)
  final double total;
  @JsonKey(name: ApiConstants.orderStatus)
  final String orderStatus;
  @JsonKey(name: ApiConstants.paymentStatus)
  final String paymentStatus;
  @JsonKey(name: ApiConstants.address)
  final String address;
  @JsonKey(name: ApiConstants.companyName)
  final String companyName;
  @JsonKey(name: ApiConstants.companyLogo)
  final String companyLogo;
  @JsonKey(name: ApiConstants.createdAt)
  final String createdAt;
  @JsonKey(name: ApiConstants.items)
  final List<OrderItemDTO> items;
  @JsonKey(name: ApiConstants.maskedCardNumber)
  final String? maskedCardNumber;

  OrderDetailsResponseDTO({
    required this.id,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
    required this.orderStatus,
    required this.paymentStatus,
    required this.address,
    required this.companyName,
    required this.companyLogo,
    required this.createdAt,
    required this.items,
    required this.maskedCardNumber,
  });

  factory OrderDetailsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsResponseDTOToJson(this);
}

@JsonSerializable()
class OrderItemDTO {
  @JsonKey(name: ApiConstants.productId)
  final int productId;
  @JsonKey(name: ApiConstants.productName)
  final String productName;
  @JsonKey(name: ApiConstants.imageUrl)
  final String imageUrl;
  @JsonKey(name: ApiConstants.price)
  final double price;
  @JsonKey(name: ApiConstants.quantity)
  final int quantity;
  @JsonKey(name: ApiConstants.options)
  final List<OrderOptionDTO>? options;

  OrderItemDTO({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.options,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDTOToJson(this);
}

@JsonSerializable()
class OrderOptionDTO {
  @JsonKey(name: ApiConstants.productOptionValueId)
  final int? productOptionValueId;
  @JsonKey(name: ApiConstants.optionName)
  final String? optionName;
  @JsonKey(name: ApiConstants.valueName)
  final String? valueName;
  @JsonKey(name: ApiConstants.extraPrice)
  final int? extraPrice;

  OrderOptionDTO({
    this.productOptionValueId,
    this.optionName,
    this.valueName,
    this.extraPrice,
  });

  factory OrderOptionDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderOptionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderOptionDTOToJson(this);
}

