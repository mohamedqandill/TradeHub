import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_cubit.dart';
import 'package:tradehub/features/vendor_profile/presentation/cubit/vendor_profile_states.dart';
import 'package:tradehub/features/vendor_profile/presentation/vendor_profile_screen_body.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var vendorId = ModalRoute.of(context)!.settings.arguments as String? ?? "";
    return BlocProvider(
      create: (context) => getIt<VendorProfileCubit>()
        ..getVendorDetails(vendorId)
        ..getVendorSubcategories(vendorId)
        ..getCompanyRatings(vendorId),
      child: BlocListener<VendorProfileCubit, VendorProfileStates>(
        listener: (context, state) {
          if (state is AddCompanyRatingErrorState) {
            showFailureSnackBar(context, messageTitle: state.error);
          } else if (state is AddCompanyRatingSuccessState) {
            showSuccessSnackBar(messageTitle: "Review Added Successfully");
          }
        },
        child: const Scaffold(
          body: VendorProfileScreenBody(),
        ),
      ),
    );
  }
}
