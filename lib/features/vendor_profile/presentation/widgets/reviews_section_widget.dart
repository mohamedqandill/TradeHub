import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../Core/colors/app_colors.dart';

class ReviewsSectionWidget extends StatelessWidget {
  const ReviewsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 12.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 8.w, left: 8.w, bottom: 15.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: context.isDarkMode ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: const [
                  BoxShadow(
                      color: AppColors.grey, spreadRadius: 1, blurRadius: 6)
                ]),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Assets.images.person.path,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mohamed Qandil",
                            style: context.base.theme.textTheme.titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: context.mainColor),
                          ),
                          Text(
                            "1 Month Ago",
                            style: context.base.theme.textTheme.titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: index < 4 ? Colors.amber : AppColors.grey,
                            size: 14.sp,
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    """Absolutely stunning chair! The quality is top-notch and it looks even better in person. It's the perfect centerpiece for my living room.""",
                    style: context.base.theme.textTheme.titleLarge?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.greyOrWhite),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
