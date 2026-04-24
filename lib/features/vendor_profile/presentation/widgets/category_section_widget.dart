import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main_layout/home/presentation/widgets/products_section.dart';

class CategorySectionWidget extends StatelessWidget {
  const CategorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: const Center(
          child: Text("No Categories"),
        ),
      ),
    );
  }
}
