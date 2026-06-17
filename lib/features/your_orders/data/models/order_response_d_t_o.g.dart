// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseDTO _$OrderResponseDTOFromJson(Map<String, dynamic> json) =>
    OrderResponseDTO(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderDataResponseDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageIndex: (json['pageIndex'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderResponseDTOToJson(OrderResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'count': instance.count,
    };

OrderDataResponseDTO _$OrderDataResponseDTOFromJson(
        Map<String, dynamic> json) =>
    OrderDataResponseDTO(
      id: (json['id'] as num?)?.toInt(),
      subTotal: (json['subTotal'] as num?)?.toInt(),
      deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      orderStatus: json['orderStatus'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      address: json['address'] as String?,
      companyName: json['companyName'] as String?,
      companyLogo: json['companyLogo'] as String?,
      createdAt: json['createdAt'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      bundleItems: (json['bundleItems'] as List<dynamic>?)
          ?.map((e) => OrderBundleItemDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataResponseDTOToJson(
        OrderDataResponseDTO instance) =>
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
      'bundleItems': instance.bundleItems,
    };

OrderItemDTO _$OrderItemDTOFromJson(Map<String, dynamic> json) => OrderItemDTO(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemDTOToJson(OrderItemDTO instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'quantity': instance.quantity,
    };

OrderBundleItemDTO _$OrderBundleItemDTOFromJson(Map<String, dynamic> json) =>
    OrderBundleItemDTO(
      bundleOfferId: (json['bundleOfferId'] as num?)?.toInt(),
      bundleName: json['bundleName'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      originalTotalPrice: (json['originalTotalPrice'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => OrderBundleProductDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderBundleItemDTOToJson(OrderBundleItemDTO instance) =>
    <String, dynamic>{
      'bundleOfferId': instance.bundleOfferId,
      'bundleName': instance.bundleName,
      'quantity': instance.quantity,
      'originalTotalPrice': instance.originalTotalPrice,
      'finalPrice': instance.finalPrice,
      'totalPrice': instance.totalPrice,
      'products': instance.products,
    };

OrderBundleProductDTO _$OrderBundleProductDTOFromJson(
        Map<String, dynamic> json) =>
    OrderBundleProductDTO(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      isGift: json['isGift'] as bool?,
    );

Map<String, dynamic> _$OrderBundleProductDTOToJson(
        OrderBundleProductDTO instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'imageUrl': instance.imageUrl,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'isGift': instance.isGift,
    };
