import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/routes/routes.dart';

class CategoryDetailsScreenBody extends StatelessWidget {
  const CategoryDetailsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterRow(context),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildVendorCard(context, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    final filters = [
      LocaleKeys.all.tr(),
      LocaleKeys.topRated.tr(),
      LocaleKeys.nearest.tr(),
      LocaleKeys.openNow.tr(),
      LocaleKeys.new_filter.tr()
    ];
    return Container(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.mainColor
                  : (context.isDarkMode
                      ? AppColors.black.withOpacity(0.3)
                      : AppColors.lightGrey),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: isSelected ? context.mainColor : Colors.transparent,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              filters[index],
              style: TextStyle(
                color: isSelected
                    ? (context.isDarkMode ? AppColors.black : AppColors.white)
                    : (context.isDarkMode ? AppColors.white : AppColors.black),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVendorCard(BuildContext context, int index) {
    final List<String> vendorNames = [
      "Modern Living",
      "Elite Furnishings",
      "Green Garden",
      "Tech World",
      "Style Hub",
      "Luxury Decor"
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.vendorProfile);
        },
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          height: 220.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Vendor Image
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Image.asset(
                    Assets.images.vendor.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
              ),
              // Vendor Info
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendorNames[index % vendorNames.length],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Premium Products & Service",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Circular Logo
                        Container(
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage(Assets.images.vendor.path),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        _buildStatusBadge(
                          icon: Icons.star_rounded,
                          label: "4.8",
                          color: Colors.amber,
                        ),
                        SizedBox(width: 8.w),
                        _buildStatusBadge(
                          icon: Icons.location_on_rounded,
                          label: "${(index + 1) * 0.5} km",
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: context.mainColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            LocaleKeys.viewDetails.tr(),
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? AppColors.black
                                  : AppColors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Open Status Tag
              Positioned(
                top: 20.h,
                right: 20.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    LocaleKeys.open.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
      {required IconData icon, required String label, required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
