import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';

Future<dynamic> successDialog(BuildContext context,void Function()? onTap) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color:
                context.isDarkMode ? const Color(0xFF0A0A0B) : AppColors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.06)
                  : Colors.black.withOpacity(0.06),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─── Icon ───
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.mainColor,
                  size: 36.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // ─── Title ───
              Text(
                "Added to Cart!",
                style: GoogleFonts.manrope(
                  color: context.isDarkMode ? AppColors.white : AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 6.h),

              // ─── Subtitle ───
              Text(
                "Item was successfully added to your cart.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: context.isDarkMode ? Colors.white54 : Colors.black45,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),

              // ─── Buttons ───
              Row(
                children: [
                  // Continue Shopping
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.06)
                              : Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: context.isDarkMode
                                ? Colors.white.withOpacity(0.08)
                                : Colors.black.withOpacity(0.08),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: GoogleFonts.manrope(
                              color: context.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  
                   
                      Expanded(
                        child: GestureDetector(
                          onTap: onTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.mainColor,
                                  Color.lerp(AppColors.mainColor, Colors.white,
                                      context.isDarkMode ? 0.15 : 0.25)!,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_rounded,
                                    size: 13.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "Go to Cart",
                                    style: GoogleFonts.manrope(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
