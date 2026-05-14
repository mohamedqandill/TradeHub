import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/assets/assets.gen.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/profile/presentation/cubit/profile_cubit.dart';
import 'package:tradehub/features/main_layout/profile/presentation/cubit/profile_state.dart';
import 'package:tradehub/features/onBoarding/view_model/theme_view_model.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? networkImageUrl;
  final double size;

  const ProfilePictureWidget({
    super.key,
    this.networkImageUrl,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // Determine current image state
        String? currentImageUrl = networkImageUrl;
        String? localImagePath;
        bool isLoading = state is ProfilePictureUploadLoading ||
            state is ProfilePictureDeleteLoading;

        if (state is ProfilePictureUploadSuccess && state.imageUrl != null) {
          // API returned the network URL, use it directly
          currentImageUrl = state.imageUrl;
          localImagePath = null;
        }
        if (state is ProfilePictureDeleteSuccess) {
          currentImageUrl = null;
          localImagePath = null;
        }

        final bool hasImage = localImagePath != null ||
            (currentImageUrl != null && currentImageUrl.isNotEmpty);

        return GestureDetector(
          onTap: () {
            if (hasImage) {
              _showFullImageDialog(context, localImagePath, currentImageUrl);
            } else {
              _showImagePickerSheet(context);
            }
          },
          child: Stack(
            children: [
              Container(
                width: size.w,
                height: size.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? AppColors.lightBlack
                      : Colors.grey.shade100,
                  border: Border.all(
                    color: context.mainColor.withOpacity(0.4),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.mainColor.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: isLoading
                      ? Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: context.mainColor,
                            ),
                          ),
                        )
                      : _buildImage(localImagePath, currentImageUrl),
                ),
              ),
              // Camera badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.sp),
                  decoration: BoxDecoration(
                    color: context.mainColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.isDarkMode
                          ? AppColors.lightBlack
                          : Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    hasImage ? Icons.edit_rounded : Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(String? localPath, String? networkUrl) {
    if (localPath != null) {
      return Image.file(
        File(localPath),
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (networkUrl != null && networkUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: networkUrl,
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
        errorWidget: (_, __, ___) => _defaultAvatar(),
      );
    }
    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return Image.asset(
      Assets.images.person.path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void _showFullImageDialog(
      BuildContext context, String? localPath, String? networkUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (dialogContext) {
        return GestureDetector(
          onTap: () => Navigator.pop(dialogContext),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Center(
                  child: Hero(
                    tag: 'profile_picture',
                    child: InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 4.0,
                      child: Container(
                        margin: EdgeInsets.all(20.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: _buildImage(localPath, networkUrl),
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 250.ms).scale(
                      begin: const Offset(0.85, 0.85),
                      end: const Offset(1, 1),
                      duration: 300.ms,
                      curve: Curves.easeOutBack,
                    ),
                // Top bar with close & actions
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10.h,
                  left: 16.w,
                  right: 16.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleButton(
                        Icons.close_rounded,
                        () => Navigator.pop(dialogContext),
                      ),
                      Row(
                        children: [
                          _circleButton(
                            Icons.edit_rounded,
                            () {
                              Navigator.pop(dialogContext);
                              _showImagePickerSheet(context);
                            },
                          ),
                          SizedBox(width: 12.w),
                          _circleButton(
                            Icons.delete_outline_rounded,
                            () {
                              Navigator.pop(dialogContext);
                              _confirmDelete(context);
                            },
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap,
      {Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.black38,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: color, size: 22.sp),
      ),
    );
  }

  void _showImagePickerSheet(BuildContext parentContext) {
    final cubit = parentContext.read<ProfileCubit>();
    showModalBottomSheet(
      context: parentContext,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isDark = parentContext.isDarkMode;
        return Container(
          margin: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Profile Photo",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.white : AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPickerOption(
                    icon: Icons.camera_alt_rounded,
                    label: "Camera",
                    color: const Color(0xFF5C6BC0),
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image != null) {
                        cubit.uploadProfilePicture(File(image.path));
                      }
                    },
                  ),
                  _buildPickerOption(
                    icon: Icons.photo_library_rounded,
                    label: "Gallery",
                    color: const Color(0xFF26A69A),
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        cubit.uploadProfilePicture(File(image.path));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext parentContext) {
    final cubit = parentContext.read<ProfileCubit>();
    final isDark = Provider.of<ThemeViewModel>(
          parentContext,
          listen: false,
        ).mode ==
        ThemeMode.dark;
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            "Remove Photo",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.white : AppColors.black,
            ),
          ),
          content: Text(
            "Are you sure you want to remove your profile photo?",
            style: TextStyle(color: AppColors.grey, fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                "Cancel",
                style: TextStyle(color: AppColors.grey, fontSize: 14.sp),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                cubit.deleteProfilePicture();
              },
              child: Text(
                "Remove",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
