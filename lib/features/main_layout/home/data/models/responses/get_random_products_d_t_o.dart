import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_product_entity.dart';

import '../../../../../../core/api/api_constant/api_constant.dart';

part 'get_random_products_d_t_o.g.dart';

@JsonSerializable()
class GetRandomProductsDTO {
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

  @JsonKey(name: ApiConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ApiConstants.logoUrl)
  final String? logoUrl;

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
  @JsonKey(name: ApiConstants.isFavourite)
  final bool? isFavourite;

  const GetRandomProductsDTO({
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
    required this.imageUrl,
    required this.logoUrl,
  });

  factory GetRandomProductsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetRandomProductsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetRandomProductsDTOToJson(this);

  toEntity() {
    return GetRandomProductEntity(
      imageUrl: imageUrl??"",
      logoUrl: logoUrl??"",
      id: id,
      name: name??"",
      description: description??"",
      price: price??0,
      quantity: quantity??0,
      categoryId: categoryId??0,
      categoryName: categoryName??"",
      companyId: companyId??"",
      companyName: companyName??"",
      attributes: attributes??[],
      averageRating: averageRating??0,
      ratingCount: ratingCount??0,
      isFavourite: isFavourite??false
    );
  }
}
