import 'package:json_annotation/json_annotation.dart';

part 'offers_response.g.dart';

@JsonSerializable()
class OffersResponse {
  @JsonKey(name: "pageIndex")
  final int? pageIndex;

  @JsonKey(name: "pageSize")
  final int? pageSize;

  @JsonKey(name: "count")
  final int? count;

  @JsonKey(name: "data")
  final List<OfferResponse>? data;

  const OffersResponse({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) =>
      _$OffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OffersResponseToJson(this);
}
@JsonSerializable()
class OfferResponse {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "companyId")
  final String? companyId;

  @JsonKey(name: "companyName")
  final String? companyName;

  @JsonKey(name: "logoUrlCompany")
  final String? logoUrlCompany;

  @JsonKey(name: "offerType")
  final String? offerType;

  @JsonKey(name: "discountPercentage")
  final double? discountPercentage;

  @JsonKey(name: "originalTotalPrice")
  final double? originalTotalPrice;

  @JsonKey(name: "finalPrice")
  final double? finalPrice;

  @JsonKey(name: "savedAmount")
  final double? savedAmount;

  @JsonKey(name: "startDate")
  final String? startDate;

  @JsonKey(name: "endDate")
  final String? endDate;

  @JsonKey(name: "isActive")
  final bool? isActive;

  @JsonKey(name: "isCurrentlyActive")
  final bool? isCurrentlyActive;

  @JsonKey(name: "items")
  final List<OfferProductItemResponse>? items;

  const OfferResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.companyId,
    required this.companyName,
    required this.logoUrlCompany,
    required this.offerType,
    required this.discountPercentage,
    required this.originalTotalPrice,
    required this.finalPrice,
    required this.savedAmount,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.isCurrentlyActive,
    required this.items,
  });

  factory OfferResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferResponseToJson(this);
}
@JsonSerializable()
class OfferProductItemResponse {
  @JsonKey(name: "productId")
  final int? productId;

  @JsonKey(name: "productName")
  final String? productName;

  @JsonKey(name: "productImage")
  final String? productImage;

  @JsonKey(name: "price")
  final double? price;

  @JsonKey(name: "quantity")
  final int? quantity;

  @JsonKey(name: "isGift")
  final bool? isGift;

  const OfferProductItemResponse({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.isGift,
  });

  factory OfferProductItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferProductItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferProductItemResponseToJson(this);
}