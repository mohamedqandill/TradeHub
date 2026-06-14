import 'package:flutter/material.dart';

enum OrderStatusFilter {
  pending(0, 'Pending', 'No pending orders', Icons.hourglass_empty_rounded),
  awaitingPayment(
    1,
    'AwaitingPayment',
    'No orders awaiting payment',
    Icons.payments_outlined,
  ),
  confirmed(
    2,
    'Confirmed',
    'No confirmed orders yet',
    Icons.verified_outlined,
  ),
  processing(
    3,
    'Processing',
    'No orders being processed',
    Icons.autorenew_rounded,
  ),
  shipped(
    4,
    'Shipped',
    'No shipped orders yet',
    Icons.local_shipping_outlined,
  ),
  delivered(
    5,
    'Delivered',
    'No delivered orders yet',
    Icons.check_circle_outline_rounded,
  ),
  cancelled(
    6,
    'Cancelled',
    'No cancelled orders',
    Icons.cancel_outlined,
  ),
  refunded(
    7,
    'Refunded',
    'No refunded orders',
    Icons.replay_rounded,
  ),
  failed(
    8,
    'Failed',
    'No failed orders',
    Icons.error_outline_rounded,
  );

  const OrderStatusFilter(
    this.value,
    this.apiName,
    this.emptyMessage,
    this.icon,
  );

  final int value;
  final String apiName;
  final String emptyMessage;
  final IconData icon;

  String get shortLabel {
    switch (this) {
      case OrderStatusFilter.pending:
        return 'Pending';
      case OrderStatusFilter.awaitingPayment:
        return 'Payment';
      case OrderStatusFilter.confirmed:
        return 'Confirmed';
      case OrderStatusFilter.processing:
        return 'Processing';
      case OrderStatusFilter.shipped:
        return 'Shipped';
      case OrderStatusFilter.delivered:
        return 'Delivered';
      case OrderStatusFilter.cancelled:
        return 'Cancelled';
      case OrderStatusFilter.refunded:
        return 'Refunded';
      case OrderStatusFilter.failed:
        return 'Failed';
    }
  }
}
