import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';

class VendorsSection extends StatelessWidget {
  final HomeCubit? cubit;
  final bool? isLoading;

  const VendorsSection({super.key, this.cubit, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading ?? false,
      child: SizedBox(
        height: 100.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: cubit?.companies.length ?? 6,
          separatorBuilder: (context, index) => SizedBox(width: 20.w),
          itemBuilder: (context, index) {
            final vendor =
                (cubit?.companies != null && index < cubit!.companies.length)
                    ? cubit!.companies[index]
                    : null;
            return InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.vendorProfile),
              child: Column(
                children: [
                  Container(
                    width: 70.w,
                    height: 70.w,
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          context.mainColor,
                          context.mainColor.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: vendor != null
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://th.bing.com/th/id/R.717ac84dfc2d28c634914f26a289340b?rik=ufWdL6Ud5vyiow&pid=ImgRaw&r=0", // Placeholder until vendor image is available
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.store),
                              )
                            : const Icon(Icons.store),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    vendor?.businessName ?? "Vendor",
                    style: TextStyle(
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
