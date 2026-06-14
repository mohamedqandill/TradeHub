import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

@JsonSerializable()
class GetRandomProductEntity {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.description)
  final String? description;
  @JsonKey(name: ApiConstants.price)
  final int? price;
  @JsonKey(name: ApiConstants.quantity)
  final int? quantity;
  @JsonKey(name: ApiConstants.categoryId)
  final int? categoryId;
  @JsonKey(name: ApiConstants.categoryName)
  final String? categoryName;
  @JsonKey(name: ApiConstants.companyId)
  final String? companyId;
  @JsonKey(name: ApiConstants.companyName)
  final String? companyName;
  @JsonKey(name: ApiConstants.attributes)
  final List<dynamic>? attributes;
  @JsonKey(name: ApiConstants.averageRating)
  final int? averageRating;
  @JsonKey(name: ApiConstants.ratingCount)
  final int? ratingCount;

  final bool? isFavourite;

  @JsonKey(name: ApiConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ApiConstants.logoUrl)
  final String? logoUrl;
  final bool? hasOffer;
  final bool? isOfferActive;
  final int? discountPercentage;
  final String? offerStartDate;
  final String? offerEndDate;
  final int? finalPrice;

  GetRandomProductEntity({
    required this.isFavourite,
    required this.imageUrl,
    required this.logoUrl,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.categoryId,
    required this.categoryName,
    required this.companyId,
    required this.companyName,
    required this.attributes,
    required this.averageRating,
    required this.ratingCount,
    required this.hasOffer,
    required this.isOfferActive,
    required this.discountPercentage,
    required this.offerStartDate,
    required this.offerEndDate,
    required this.finalPrice,
  });

  GetRandomProductEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? quantity,
    int? categoryId,
    String? categoryName,
    String? companyId,
    String? companyName,
    List<dynamic>? attributes,
    int? averageRating,
    int? ratingCount,
    bool? isFavourite,
    String? imageUrl,
    String? logoUrl,
    bool? hasOffer,
    bool? isOfferActive,
    int? discountPercentage,
    String? offerStartDate,
    String? offerEndDate,
    int? finalPrice,
  }) {
    return GetRandomProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      attributes: attributes ?? this.attributes,
      averageRating: averageRating ?? this.averageRating,
      ratingCount: ratingCount ?? this.ratingCount,
      isFavourite: isFavourite ?? this.isFavourite,
      imageUrl: imageUrl ?? this.imageUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      hasOffer: hasOffer ?? this.hasOffer,
      isOfferActive: isOfferActive ?? this.isOfferActive,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      offerStartDate: offerStartDate ?? this.offerStartDate,
      offerEndDate: offerEndDate ?? this.offerEndDate,
      finalPrice: finalPrice ?? this.finalPrice,
    );
  }
}
