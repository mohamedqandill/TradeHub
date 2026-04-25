import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'product_rating_d_t_o.g.dart';

@JsonSerializable()
class ProductRatingDTO {
  @JsonKey(name: ApiConstants.id)
  final int? id;

  @JsonKey(name: ApiConstants.ratingValue)
  final int? ratingValue;

  @JsonKey(name: ApiConstants.comment)
  final String? comment;

  @JsonKey(name: ApiConstants.userId)
  final String? userId;

  @JsonKey(name: ApiConstants.userFullname)
  final String? userFullname;

  @JsonKey(name: ApiConstants.createdAt)
  final String? createdAt;

  const ProductRatingDTO({
    required this.id,
    required this.ratingValue,
    required this.comment,
    required this.userId,
    required this.userFullname,
    required this.createdAt,
  });

  factory ProductRatingDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRatingDTOToJson(this);
}

