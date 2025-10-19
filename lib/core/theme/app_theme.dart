import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/core/colors/app_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.mainColor))),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: AppColors.mainColor,
        labelStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.grey),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.red),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.red),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
      ),
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
            color: AppColors.grey),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
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
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainDarkColor),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.red),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.red),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.white),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.white),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.white),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
            fontSize: 36.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey),
        bodyMedium: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainDarkColor),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.mainDarkColor),
        titleLarge: GoogleFonts.poppins(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
      ));
}
