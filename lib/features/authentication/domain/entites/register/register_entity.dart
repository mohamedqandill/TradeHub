class RegisterEntity {
  final String? fullName;
  final String? token;
  final String? refreshToken;

  RegisterEntity(
      {required this.token,
      required this.refreshToken,
      required this.fullName});
}
