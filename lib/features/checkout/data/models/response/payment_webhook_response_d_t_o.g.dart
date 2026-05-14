// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_webhook_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentWebhookRequest _$PaymentWebhookRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentWebhookRequest(
      obj: json['obj'] == null
          ? null
          : WebhookObject.fromJson(json['obj'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentWebhookRequestToJson(
        PaymentWebhookRequest instance) =>
    <String, dynamic>{
      'obj': instance.obj,
    };

WebhookObject _$WebhookObjectFromJson(Map<String, dynamic> json) =>
    WebhookObject(
      id: (json['id'] as num?)?.toInt(),
      sourceData: json['source_data'] == null
          ? null
          : SourceData.fromJson(json['source_data'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      pending: json['pending'] as bool?,
      extras: json['extras'] == null
          ? null
          : WebhookExtras.fromJson(json['extras'] as Map<String, dynamic>),
      order: json['order'] == null
          ? null
          : WebhookOrder.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookObjectToJson(WebhookObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'success': instance.success,
      'pending': instance.pending,
      'extras': instance.extras,
      'order': instance.order,
      'source_data': instance.sourceData,
    };

WebhookExtras _$WebhookExtrasFromJson(Map<String, dynamic> json) =>
    WebhookExtras(
      orderId: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WebhookExtrasToJson(WebhookExtras instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
    };

WebhookOrder _$WebhookOrderFromJson(Map<String, dynamic> json) => WebhookOrder(
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WebhookOrderToJson(WebhookOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SourceData _$SourceDataFromJson(Map<String, dynamic> json) => SourceData(
      type: json['type'] as String?,
      pan: json['pan'] as String?,
      subType: json['sub_type'] as String?,
    );

Map<String, dynamic> _$SourceDataToJson(SourceData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'pan': instance.pan,
      'sub_type': instance.subType,
    };
