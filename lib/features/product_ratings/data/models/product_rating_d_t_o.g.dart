// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_rating_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRatingDTO _$ProductRatingDTOFromJson(Map<String, dynamic> json) =>
    ProductRatingDTO(
      id: (json['id'] as num?)?.toInt(),
      ratingValue: (json['ratingValue'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      userId: json['userId'] as String?,
      userFullname: json['userFullname'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ProductRatingDTOToJson(ProductRatingDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ratingValue': instance.ratingValue,
      'comment': instance.comment,
      'userId': instance.userId,
      'userFullname': instance.userFullname,
      'createdAt': instance.createdAt,
    };
