import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/vendor_card.dart';

class VendorsSection extends StatefulWidget {
  final HomeCubit? cubit;
  final bool? isLoading;

  const VendorsSection({super.key, this.cubit, this.isLoading});

  @override
  State<VendorsSection> createState() => _VendorsSectionState();
}

class _VendorsSectionState extends State<VendorsSection> {
  late final ScrollController _scrollController;
  Timer? _autoScrollTimer;
  bool _isScrollingForward = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;

      if (_isScrollingForward) {
        final nextScroll = currentScroll + 280.w;

        if (nextScroll >= maxScroll) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
          );
          _isScrollingForward = true;
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading ?? false,
      child: SizedBox(
        height: 180.h,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: widget.cubit?.companies.length ?? 6,
          separatorBuilder: (context, index) => SizedBox(width: 16.w),
          itemBuilder: (context, index) {
            final vendor = (widget.cubit?.companies != null &&
                    index < widget.cubit!.companies.length)
                ? widget.cubit!.companies[index]
                : null;
            return VendorCard(vendor: vendor);
          },
        ),
      ),
    );
  }
}
