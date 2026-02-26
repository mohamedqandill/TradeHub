import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/filter_row_widget.dart';
import 'widgets/vendor_card_widget.dart';

class CategoryDetailsScreenBody extends StatelessWidget {
  const CategoryDetailsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FilterRowWidget(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return VendorCardWidget(index: index);
            },
          ),
        ),
      ],
    );
  }
}
