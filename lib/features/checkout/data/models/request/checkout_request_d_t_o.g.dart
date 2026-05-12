// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRequestDTO _$CheckoutRequestDTOFromJson(Map<String, dynamic> json) =>
    CheckoutRequestDTO(
      basketId: (json['basketId'] as num?)?.toInt(),
      deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CheckoutRequestDTOToJson(CheckoutRequestDTO instance) =>
    <String, dynamic>{
      'basketId': instance.basketId,
      'deliveryFee': instance.deliveryFee,
      'address': instance.address,
    };
