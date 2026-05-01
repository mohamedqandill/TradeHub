class CategoryCompanyEntity {
  final String? companyName;
  final String? categoryName;
  final String? locationName;
  final String? businessTypeName;
  final String? logoUrl;
  final String? taxNumber;
  final String? companyId;

  CategoryCompanyEntity({
    required this.companyId,
    required this.companyName,
    required this.categoryName,
    required this.locationName,
    required this.businessTypeName,
    required this.logoUrl,
    required this.taxNumber,
  });
}
