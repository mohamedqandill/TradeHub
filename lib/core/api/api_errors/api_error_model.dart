class ErrorsModel {
  final String message;
  final int? statusCode;

  ErrorsModel({
    required this.message,
    this.statusCode,
  });

  factory ErrorsModel.fromJson(Map<String, dynamic> json) {
    return ErrorsModel(
      message: json['message'] ?? '',
      statusCode: json['status_code'],
    );
  }
}

class ServerExceptions implements Exception {
  final ErrorsModel errorsModel;
  ServerExceptions({required this.errorsModel});
}
