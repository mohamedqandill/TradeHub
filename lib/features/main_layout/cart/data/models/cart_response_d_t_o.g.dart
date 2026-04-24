// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseDTO _$CartResponseDTOFromJson(Map<String, dynamic> json) =>
    CartResponseDTO(
      id: (json['id'] as num).toInt(),
      buyerId: json['buyerId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: (json['subTotal'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CartResponseDTOToJson(CartResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buyerId': instance.buyerId,
      'items': instance.items,
      'subTotal': instance.subTotal,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: (json['id'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'pictureUrl': instance.pictureUrl,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
    };
