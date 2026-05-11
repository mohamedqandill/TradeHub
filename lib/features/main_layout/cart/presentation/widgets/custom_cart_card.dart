import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class CustomCartCard extends StatefulWidget {
  const CustomCartCard({
    super.key,
    required this.image,
    required this.title,
    this.size,
    required this.price,
    required this.quantity,
    required this.onUpdateQuantity,
    this.color,
  });

  final String image;
  final String title;
  final String? size;
  final String? color;
  final String price;
  final int quantity;
  final Function(int) onUpdateQuantity;

  @override
  State<CustomCartCard> createState() => _CustomCartCardState();
}

class _CustomCartCardState extends State<CustomCartCard> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.quantity;
  }

  @override
  void didUpdateWidget(covariant CustomCartCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.quantity != oldWidget.quantity) {
      count = widget.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayImage = widget.image.isEmpty
        ? "https://pngate.com/wp-content/uploads/2025/04/samsung-galaxy-s25-blue-all-angles-1.png"
        : widget.image;

    final double itemPrice = double.tryParse(widget.price) ?? 0;
    final double totalPrice = itemPrice * count;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: context.isDarkMode
              ? Colors.white10
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : AppColors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: displayImage.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: displayImage,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.grey,
                        size: 24.sp,
                      ),
                    )
                  : Image.asset(
                      displayImage,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      "${widget.price} EGP",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    if (widget.size != null) ...[
                      const Text(" • ",
                          style: TextStyle(color: AppColors.grey)),
                      Text(
                        "Size ${widget.size}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$totalPrice EGP",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        color: context.mainColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.05)
                            : AppColors.grey.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          _buildCounterBtn(
                            icon: count == 1
                                ? Icons.delete_outline_rounded
                                : Icons.remove_rounded,
                            iconColor: count == 1 ? Colors.redAccent : null,
                            onTap: () {
                              if (count == 1) {
                                widget.onUpdateQuantity(0);
                              } else if (count > 1) {
                                widget.onUpdateQuantity(count - 1);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: context.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          _buildCounterBtn(
                            icon: Icons.add_rounded,
                            isPrimary: true,
                            onTap: () {
                              widget.onUpdateQuantity(count + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterBtn({
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: isPrimary ? context.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: context.mainColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: iconColor ?? (isPrimary ? Colors.white : AppColors.grey),
        ),
      ),
    );
  }
}
