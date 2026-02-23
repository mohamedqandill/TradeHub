import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../../../../Core/colors/app_colors.dart';
import '../../../../../core/assets/assets.gen.dart';

class VendorsSection extends StatelessWidget {
  const VendorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 2,
            crossAxisCount: 1,
            mainAxisSpacing: 15.sp,
            mainAxisExtent: 256.sp),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.vendorProfile);
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  Assets.images.vendor.path,
                  height: 165.h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  left: 10.w,
                  bottom: 20.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vendor One",
                        style: context.base.theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.white, fontSize: 18.sp),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.sp,
                          ),
                          Text(
                            "4.5 Rating",
                            style: context.base.theme.textTheme.bodyMedium
                                ?.copyWith(
                                    color: AppColors.white, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
