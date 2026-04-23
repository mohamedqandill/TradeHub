import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'product_details_response_d_t_o.g.dart';

@JsonSerializable()
class ProductDetailsResponseDTO {
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
  final List<Attributes>? attributes;
  @JsonKey(name: ApiConstants.averageRating)
  final int? averageRating;
  @JsonKey(name: ApiConstants.ratingCount)
  final int? ratingCount;
  @JsonKey(name: ApiConstants.isFavourite)
  final bool? isFavourite;

  const ProductDetailsResponseDTO({
    required this.isFavourite,
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

  factory ProductDetailsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseDTOToJson(this);
}

@JsonSerializable()
class Attributes {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.categoryAttributeId)
  final int? categoryAttributeId;
  @JsonKey(name: ApiConstants.categoryAttributeName)
  final String? categoryAttributeName;
  @JsonKey(defaultValue: '')
  final String? value;

  const Attributes({
    required this.id,
    required this.categoryAttributeId,
    required this.categoryAttributeName,
    required this.value,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
