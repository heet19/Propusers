class VerifyUserModel {
  final bool success;
  final String message;

  VerifyUserModel({
    required this.success,
    required this.message,
  });

  factory VerifyUserModel.fromJson(Map<String, dynamic> json) {
    return VerifyUserModel(
      success: json['success'] ?? false,
      message: json['data']?['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
