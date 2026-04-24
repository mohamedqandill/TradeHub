import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_cubit.dart';
import 'package:tradehub/features/vendor_profile/presentation/vendor_profile_screen_body.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var vendorId = ModalRoute.of(context)!.settings.arguments as String? ?? "";
    return BlocProvider(
      create: (context) => getIt<VendorProfileCubit>()
        ..getVendorDetails(vendorId)
        ..getVendorSubcategories(vendorId),
      child: const Scaffold(
        body: VendorProfileScreenBody(),
      ),
    );
  }
}
