// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponseDTO _$CheckoutResponseDTOFromJson(Map<String, dynamic> json) =>
    CheckoutResponseDTO(
      orderId: (json['orderId'] as num?)?.toInt(),
      clientSecret: json['clientSecret'] as String?,
      paymentIntentId: json['paymentIntentId'] as String?,
      publicKey: json['publicKey'] as String?,
      paymentUrl: json['paymentUrl'] as String?,
    );

Map<String, dynamic> _$CheckoutResponseDTOToJson(
        CheckoutResponseDTO instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'clientSecret': instance.clientSecret,
      'paymentIntentId': instance.paymentIntentId,
      'publicKey': instance.publicKey,
      'paymentUrl': instance.paymentUrl,
    };
