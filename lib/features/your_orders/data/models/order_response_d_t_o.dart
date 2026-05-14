import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'order_response_d_t_o.g.dart';

@JsonSerializable()
class OrderResponseDTO {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.subTotal)
  final int? subTotal;
  @JsonKey(name: ApiConstants.deliveryFee)
  final int? deliveryFee;
  @JsonKey(name: ApiConstants.total)
  final int? total;
  @JsonKey(name: ApiConstants.orderStatus)
  final String? orderStatus;
  @JsonKey(name: ApiConstants.paymentStatus)
  final String? paymentStatus;
  @JsonKey(name: ApiConstants.address)
  final String? address;
  @JsonKey(name: ApiConstants.companyName)
  final String? companyName;
  @JsonKey(name: ApiConstants.companyLogo)
  final String? companyLogo;
  @JsonKey(name: ApiConstants.createdAt)
  final String? createdAt;
  @JsonKey(name: ApiConstants.items)
  final List<OrderItemDTO>? items;

  const OrderResponseDTO({
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
  });

  factory OrderResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseDTOToJson(this);
}

@JsonSerializable()
class OrderItemDTO {
  @JsonKey(name: ApiConstants.productId)
  final int? productId;
  @JsonKey(name: ApiConstants.productName)
  final String? productName;
  @JsonKey(name: ApiConstants.imageUrl)
  final String? imageUrl;
  @JsonKey(name: ApiConstants.price)
  final int? price;
  @JsonKey(name: ApiConstants.quantity)
  final int? quantity;

  const OrderItemDTO({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDTOToJson(this);
}
