import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/colors/app_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
            fontSize: 36.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 36.sp,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black),
      ));
}
