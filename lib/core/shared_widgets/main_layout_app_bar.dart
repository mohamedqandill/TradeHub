import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class MainLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainLayoutAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: context.base.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.mainColor,
            fontSize: 22.sp),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(35.h);
}
