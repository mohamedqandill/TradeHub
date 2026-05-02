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

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.black.withOpacity(0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        // border: Border.all(
        //   color: context.isDarkMode ? Colors.white12 : Colors.transparent,
        //   width: 1,
        // ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: displayImage.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: displayImage,
                    width: 100.w,
                    height: 90.w,
                    fit: BoxFit.contain,
                    
                    errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.grey,
                      size: 30.sp,
                    ),
                  )
                : Image.asset(
                    displayImage,
                    width: 90.w,
                    height: 90.w,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (widget.size != null)
                      Text(
                        "SIZE: ${widget.size}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (widget.size != null && widget.color != null)
                      Text(" | ", style: TextStyle(color: AppColors.grey)),
                    if (widget.color != null)
                      Text(
                        "COLOR: ${widget.color}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.price} EGP",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: context.mainColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.white.withOpacity(0.05)
                            : AppColors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: context.isDarkMode
                              ? Colors.white12
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildCounterBtn(
                            icon: count == 1 ? Icons.delete : Icons.remove,
                            iconColor: count == 1 ? Colors.red : null,
                            onTap: () {
                              if (count == 1) {
                                widget.onUpdateQuantity(0);
                              } else if (count > 1) {
                                widget.onUpdateQuantity(count - 1);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ),
                          _buildCounterBtn(
                            icon: Icons.add,
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
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: isPrimary ? context.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: iconColor ?? (isPrimary ? Colors.white : AppColors.grey),
        ),
      ),
    );
  }
}
