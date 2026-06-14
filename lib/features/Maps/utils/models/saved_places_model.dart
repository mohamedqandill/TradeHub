class SavedPlacesModel {
  final double latitude;
  final double longitude;
  final String placeName;
  final String placeCountry;

  SavedPlacesModel({
    required this.latitude,
    required this.longitude,
    required this.placeName,
    required this.placeCountry,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'placeName': placeName,
      'placeCountry': placeCountry,
    };
  }

  factory SavedPlacesModel.fromJson(Map<dynamic, dynamic> json) {
    return SavedPlacesModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      placeName: json['placeName'] as String,
      placeCountry: json['placeCountry'] as String? ?? '',
    );
  }
}
