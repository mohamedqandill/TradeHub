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

  GetRandomProductEntity({
    required this.isFavourite,
        required this.imageUrl,
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
  });
}
