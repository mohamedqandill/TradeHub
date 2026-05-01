import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';

class VendorCardWidget extends StatelessWidget {
  final CategoryCompanyEntity company;

  const VendorCardWidget({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.vendorProfile,
                arguments: company.companyId);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color:
                      context.isDarkMode ? AppColors.lightBlack : Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: context.isDarkMode
                        ? Colors.white12
                        : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: company.logoUrl ?? "",
                    errorWidget: (context, url, error) => Container(
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.06)
                          : AppColors.lightGrey,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.storefront_outlined,
                        size: 24.sp,
                        color: AppColors.grey.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.companyName ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${company.categoryName ?? ""} • ${company.businessTypeName ?? ""}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: context.isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            company.locationName ?? "",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: context.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.confirmation_number_outlined,
                            color: context.isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "Tax: ${company.taxNumber ?? "-"}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Divider(
            color: context.isDarkMode ? Colors.white12 : Colors.grey.shade200,
            thickness: 2,
            height: 1,
          ),
        )
      ],
    );
  }
}
