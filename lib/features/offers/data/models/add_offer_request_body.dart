class AddOfferRequestBody {
  final int offerId;
  final int quantity;

  AddOfferRequestBody({required this.offerId, required this.quantity});

  Map<String, int> toJson() => {
    "bundleOfferId": offerId,
    "quantity": quantity,
  };
}