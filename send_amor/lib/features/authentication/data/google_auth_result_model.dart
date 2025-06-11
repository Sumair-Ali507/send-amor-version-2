class GoogleAuthResultModel {
  final bool success;
  final String? errorMessage;

  GoogleAuthResultModel({
    required this.success,
    this.errorMessage,
  });
}
