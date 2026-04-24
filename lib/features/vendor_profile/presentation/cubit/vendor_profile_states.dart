import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';

abstract class VendorProfileStates {}

class VendorProfileInitialState extends VendorProfileStates {}

class GetVendorDetailsLoadingState extends VendorProfileStates {}

class GetVendorDetailsSuccessState extends VendorProfileStates {}

class GetVendorDetailsErrorState extends VendorProfileStates {
  final String error;
  GetVendorDetailsErrorState(this.error);
}

class GetVendorSubcategoriesLoadingState extends VendorProfileStates {}

class GetVendorSubcategoriesSuccessState extends VendorProfileStates {}

class GetVendorSubcategoriesErrorState extends VendorProfileStates {
  final String error;
  GetVendorSubcategoriesErrorState(this.error);
}

class GetProductsBySubcategoryLoadingState extends VendorProfileStates {}

class GetProductsBySubcategorySuccessState extends VendorProfileStates {}

class GetProductsBySubcategoryErrorState extends VendorProfileStates {
  final String error;
  GetProductsBySubcategoryErrorState(this.error);
}
