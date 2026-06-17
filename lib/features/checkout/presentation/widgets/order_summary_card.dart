import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';

class OrderSummaryCard extends StatefulWidget {
  final List<Items> items;
  final int subTotal;
  final bool initiallyExpanded;

  const OrderSummaryCard({
    super.key,
    required this.items,
    required this.subTotal,
    this.initiallyExpanded = false,
  });

  @override
  State<OrderSummaryCard> createState() => _OrderSummaryCardState();
}

class _OrderSummaryCardState extends State<OrderSummaryCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(covariant OrderSummaryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      _isExpanded = widget.initiallyExpanded;
    }
  }

  // Returns a representative image for the collapsed preview.
  // Bundle items have no pictureUrl, so fall back to the first product
  // image inside the offer.
  String _previewImage(Items item) {
    if (item.isBundleOffer == true && item.offerBundle != null) {
      final inner = item.offerBundle!.items ?? [];
      if (inner.isNotEmpty) return inner.first.productImage ?? "";
    }
    return item.pictureUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final primaryColor = context.mainColor;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E20) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.04),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 16.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header / Collapsed Preview Toggle
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  // Overlapping Images (Stack of thumbnails)
                  SizedBox(
                    width: (widget.items.length > 3 ? 3 : widget.items.length) *
                            20.w +
                        16.w,
                    height: 32.h,
                    child: Stack(
                      children: List.generate(
                        widget.items.length > 3 ? 3 : widget.items.length,
                        (index) {
                          return Positioned(
                            left: index * 18.w,
                            child: Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? const Color(0xFF2C2C2E)
                                    : const Color(0xFFF3F4F6),
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF1E1E20)
                                      : Colors.white,
                                  width: 2.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: CachedNetworkImage(
                                  imageUrl: _previewImage(widget.items[index]),
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 14.sp,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Items count
                  Text(
                    "${widget.items.length} ${widget.items.length == 1 ? 'Item' : 'Items'}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Spacer(),
                  // Total Price Preview
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${widget.subTotal} EGP",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.w),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.grey,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expanded Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                const Divider(height: 1, color: Colors.white10),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // List of items (bundle offers show an offer summary)
                      Column(
                        children: List.generate(widget.items.length, (index) {
                          final item = widget.items[index];
                          final bool isBundle = item.isBundleOffer == true &&
                              item.offerBundle != null;
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: index == widget.items.length - 1
                                    ? 0
                                    : 12.h),
                            child: isBundle
                                ? _buildBundleSummary(
                                    item, isDark, primaryColor)
                                : _buildNormalItemRow(item, isDark),
                          );
                        }),
                      ),

                      SizedBox(height: 16.h),
                      Divider(
                          color: isDark
                              ? Colors.white10
                              : Colors.black.withOpacity(0.05)),
                      SizedBox(height: 12.h),

                      // Pricing Details
                      _buildPriceRow(
                        label: "Subtotal",
                        value: "${widget.subTotal} EGP",
                        isDark: isDark,
                      ),
                      SizedBox(height: 10.h),
                      _buildPriceRow(
                        label: "Shipping",
                        value: "Free",
                        valueColor: const Color(0xFF2E7D32),
                        isDark: isDark,
                        isBoldValue: true,
                      ),
                      SizedBox(height: 12.h),
                      Divider(
                          color: isDark
                              ? Colors.white10
                              : Colors.black.withOpacity(0.05)),
                      SizedBox(height: 12.h),

                      // Grand Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            "${widget.subTotal} EGP",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w800,
                              color: primaryColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  // ── Normal product row (original design, extracted unchanged) ──────────────
  Widget _buildNormalItemRow(Items item, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Container(
          width: 48.w,
          height: 40.w,
          decoration: BoxDecoration(
            color:
                isDark ? Colors.white10 : AppColors.lightGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: item.pictureUrl ?? "",
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => Icon(
                Icons.image_not_supported_outlined,
                size: 16.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Product Title & Options
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
              if (item.options != null && item.options!.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 2.h,
                  children: item.options!.map((opt) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color:
                            isDark ? Colors.white10 : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "${opt.optionName}: ${opt.valueName}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 8.w),
        // Price and Quantity
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${item.price} EGP",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            Text(
              "x${item.quantity}",
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Bundle offer summary: offer name + description + product images ────────
  Widget _buildBundleSummary(Items item, bool isDark, Color primaryColor) {
    final offer = item.offerBundle!;
    final inner = offer.items ?? [];

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color:
            isDark ? Colors.white.withOpacity(0.04) : const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: primaryColor.withOpacity(0.30),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: offer tag + name + price/qty
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.local_offer_rounded, size: 14.sp, color: primaryColor),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.name ?? "Bundle Offer",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black87,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Bundle Offer • ${inner.length} items",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${item.price} EGP",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  Text(
                    "x${item.quantity}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Offer description (e.g. "Big Mac + Cola")
          if ((offer.description ?? "").isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              offer.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
                fontFamily: 'Poppins',
              ),
            ),
          ],

          SizedBox(height: 10.h),

          // Images of the products inside the offer
          SizedBox(
            height: 62.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: inner.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, i) {
                final p = inner[i];
                return SizedBox(
                  width: 44.w,
                  child: Column(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isDark
                                ? Colors.white10
                                : Colors.black.withOpacity(0.06),
                            width: 1.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            imageUrl: p.productImage ?? "",
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => Icon(
                              Icons.fastfood_rounded,
                              size: 16.sp,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        p.productName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow({
    required String label,
    required String value,
    required bool isDark,
    Color? valueColor,
    bool isBoldValue = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: isBoldValue ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? (isDark ? Colors.white70 : Colors.black87),
          ),
        ),
      ],
    );
  }
}
