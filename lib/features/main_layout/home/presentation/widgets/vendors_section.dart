import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/routes/routes.dart';

import '../../../../../core/assets/assets.gen.dart';

class VendorsSection extends StatelessWidget {
  const VendorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      Assets.images.karamelshaam.path,
      Assets.images.etoile.path,
      Assets.images.blbn.path,
    ];
    List<String> titles = [
      "Karm El-Sham",
      "Etoile",
      "B-L A B A N",
    ];
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.vendorProfile);
              },
              borderRadius: BorderRadius.circular(24.r),
              child: Container(
                width: 260.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: Image.asset(
                        images[index],
                        width: 300.w,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Glassmorphism-style Info Overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 70.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(24.r)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              titles[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.2,
                                shadows: [
                                  Shadow(color: Colors.black45, blurRadius: 4)
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Special Offers Available",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Floating Badge (Rating)
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star_rounded,
                                color: Colors.amber, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              "4.8",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
