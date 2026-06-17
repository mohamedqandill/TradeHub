import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class CollapsedShippingCard extends StatelessWidget {
  final String recipientName;
  final String address;
  final String phoneNumber;
  final VoidCallback onEdit;

  const CollapsedShippingCard({
    super.key,
    required this.recipientName,
    required this.address,
    required this.phoneNumber,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final primaryColor = context.mainColor;

    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Circle Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.14),
                  primaryColor.withOpacity(0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_pin,
              color: primaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 14.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipientName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white60 : Colors.black54,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (phoneNumber.isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.call_rounded,
                        color: primaryColor.withOpacity(0.75),
                        size: 13.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        phoneNumber,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Edit button
          InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: isDark
                    ? primaryColor.withOpacity(0.12)
                    : primaryColor.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_rounded,
                    size: 12.sp,
                    color: primaryColor,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
