import 'package:flutter/material.dart';

enum ProductSortOption {
  priceAsc(
    'priceasc',
    'Price',
    'Low to High',
    Icons.trending_up_rounded,
  ),
  priceDesc(
    'pricedesc',
    'Price',
    'High to Low',
    Icons.trending_down_rounded,
  ),
  ratingAsc(
    'ratingasc',
    'Rating',
    'Low to High',
    Icons.star_outline_rounded,
  ),
  ratingDesc(
    'ratingdesc',
    'Rating',
    'High to Low',
    Icons.star_rounded,
  );

  const ProductSortOption(
    this.apiValue,
    this.label,
    this.subtitle,
    this.icon,
  );

  final String apiValue;
  final String label;
  final String subtitle;
  final IconData icon;

  static ProductSortOption? fromApiValue(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final option in ProductSortOption.values) {
      if (option.apiValue == value) return option;
    }
    return null;
  }
}
