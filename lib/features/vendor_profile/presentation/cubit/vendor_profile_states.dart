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

class GetCompanyRatingsLoadingState extends VendorProfileStates {}

class GetCompanyRatingsSuccessState extends VendorProfileStates {}

class GetCompanyRatingsErrorState extends VendorProfileStates {
  final String error;
  GetCompanyRatingsErrorState(this.error);
}

class AddCompanyRatingLoadingState extends VendorProfileStates {}

class AddCompanyRatingSuccessState extends VendorProfileStates {}

class AddCompanyRatingErrorState extends VendorProfileStates {
  final String error;
  AddCompanyRatingErrorState(this.error);
}
