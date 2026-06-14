// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsResponseDTO _$OrderDetailsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    OrderDetailsResponseDTO(
      id: (json['id'] as num).toInt(),
      subTotal: (json['subTotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      orderStatus: json['orderStatus'] as String,
      paymentStatus: json['paymentStatus'] as String,
      address: json['address'] as String,
      companyName: json['companyName'] as String,
      companyLogo: json['companyLogo'] as String,
      createdAt: json['createdAt'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      maskedCardNumber: json['maskedCardNumber'] as String?,
    );

Map<String, dynamic> _$OrderDetailsResponseDTOToJson(
        OrderDetailsResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subTotal': instance.subTotal,
      'deliveryFee': instance.deliveryFee,
      'total': instance.total,
      'orderStatus': instance.orderStatus,
      'paymentStatus': instance.paymentStatus,
      'address': instance.address,
      'companyName': instance.companyName,
      'companyLogo': instance.companyLogo,
      'createdAt': instance.createdAt,
      'items': instance.items,
      'maskedCardNumber': instance.maskedCardNumber,
    };

OrderItemDTO _$OrderItemDTOFromJson(Map<String, dynamic> json) => OrderItemDTO(
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OrderOptionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderItemDTOToJson(OrderItemDTO instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'quantity': instance.quantity,
      'options': instance.options,
    };

OrderOptionDTO _$OrderOptionDTOFromJson(Map<String, dynamic> json) =>
    OrderOptionDTO(
      productOptionValueId: (json['productOptionValueId'] as num?)?.toInt(),
      optionName: json['optionName'] as String?,
      valueName: json['valueName'] as String?,
      extraPrice: (json['extraPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderOptionDTOToJson(OrderOptionDTO instance) =>
    <String, dynamic>{
      'productOptionValueId': instance.productOptionValueId,
      'optionName': instance.optionName,
      'valueName': instance.valueName,
      'extraPrice': instance.extraPrice,
    };
