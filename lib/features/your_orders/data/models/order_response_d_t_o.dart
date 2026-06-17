import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'order_response_d_t_o.g.dart';

@JsonSerializable()
class OrderResponseDTO {
  @JsonKey(name: ApiConstants.data)
  final List<OrderDataResponseDTO>? data;
  @JsonKey(name: ApiConstants.pageIndex)
  final int? pageIndex;
  @JsonKey(name: ApiConstants.pageSize)
  final int? pageSize;
  @JsonKey(name: ApiConstants.count)
  final int? count;

  const OrderResponseDTO({
    required this.data,
    required this.pageIndex,
    required this.pageSize,
    required this.count,
  });

  factory OrderResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseDTOToJson(this);
}

@JsonSerializable()
class OrderDataResponseDTO {
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

  @JsonKey(name: ApiConstants.bundleItems)
  final List<OrderBundleItemDTO>? bundleItems;

  const OrderDataResponseDTO({
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
    this.bundleItems
  });

  factory OrderDataResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDataResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataResponseDTOToJson(this);
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


@JsonSerializable()
class OrderBundleItemDTO {
  @JsonKey(name: ApiConstants.bundleOfferId)
  final int? bundleOfferId;

  @JsonKey(name: ApiConstants.bundleName)
  final String? bundleName;

  @JsonKey(name: ApiConstants.quantity)
  final int? quantity;

  @JsonKey(name: ApiConstants.originalTotalPrice)
  final int? originalTotalPrice;

  @JsonKey(name: ApiConstants.finalPrice)
  final int? finalPrice;

  @JsonKey(name: ApiConstants.totalPrice)
  final int? totalPrice;

  @JsonKey(name: ApiConstants.products)
  final List<OrderBundleProductDTO>? products;

  const OrderBundleItemDTO({
    required this.bundleOfferId,
    required this.bundleName,
    required this.quantity,
    required this.originalTotalPrice,
    required this.finalPrice,
    required this.totalPrice,
    required this.products,
  });

  factory OrderBundleItemDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderBundleItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBundleItemDTOToJson(this);
}
@JsonSerializable()
class OrderBundleProductDTO {
  @JsonKey(name: ApiConstants.productId)
  final int? productId;

  @JsonKey(name: ApiConstants.productName)
  final String? productName;

  @JsonKey(name: ApiConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ApiConstants.unitPrice)
  final int? unitPrice;

  @JsonKey(name: ApiConstants.quantity)
  final int? quantity;

  @JsonKey(name: ApiConstants.isGift)
  final bool? isGift;

  const OrderBundleProductDTO({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    required this.isGift,
  });

  factory OrderBundleProductDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderBundleProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBundleProductDTOToJson(this);
}