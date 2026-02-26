import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/buttons/custom_large_main_button.dart';
import 'package:tradehub/core/shared_widgets/fields/custom_text_field.dart';

class GetHelpBody extends StatelessWidget {
  const GetHelpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      children: [
        Text(
          tr(LocaleKeys.howCanWeHelpYou),
          style: context.base.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 26.sp,
            color: context.isDarkMode ? AppColors.white : AppColors.black,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          tr(LocaleKeys.getHelpDescription),
          style: context.base.theme.textTheme.bodyMedium?.copyWith(
            fontSize: 15.sp,
            height: 1.5,
            color: context.isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        SizedBox(height: 32.h),

        // Issue Field
        CustomTextField(
          labelText: tr(LocaleKeys.issue),
          hintText: tr(LocaleKeys.describeIssueHere),
        ),
        SizedBox(height: 16.h),

        // Message Field
        SizedBox(
          child: TextFormField(
            maxLines: 4,
            style: Theme.of(context).textTheme.labelSmall,
            decoration: InputDecoration(
              isDense: true,
              labelText: tr(LocaleKeys.message),
              alignLabelWithHint: true,
              hintText: tr(LocaleKeys.addExtraDetails),
              errorStyle: context.base.theme.textTheme.bodySmall!
                  .copyWith(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 24.h),

        CustomLargeMainButton(
          text: tr(LocaleKeys.send),
          onPressed: () {},
        ),

        SizedBox(height: 48.h),

        Center(
          child: Column(
            children: [
              Text(
                tr(LocaleKeys.reachOutOnSocials),
                style: context.base.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: context.isDarkMode ? Colors.white60 : Colors.black54,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(
                      context, Icons.facebook_outlined, Colors.blue),
                  SizedBox(width: 20.w),
                  _buildSocialIcon(
                      context, Icons.ondemand_video_outlined, Colors.red),
                  SizedBox(width: 20.w),
                  _buildSocialIcon(
                      context, Icons.camera_alt_outlined, Colors.pink),
                  SizedBox(width: 20.w),
                  _buildSocialIcon(
                      context, Icons.code_rounded, Colors.black), // X (Twitter)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(
          color: context.isDarkMode ? Colors.white12 : Colors.grey.shade100,
        ),
      ),
      child: Icon(
        icon,
        color:
            context.isDarkMode && color == Colors.black ? Colors.white : color,
        size: 24.sp,
      ),
    );
  }
}
