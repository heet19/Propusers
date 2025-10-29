class SignUpModel {
  final bool success;
  final int id;
  final String email;
  final int otp;

  SignUpModel({
    required this.success,
    required this.id,
    required this.email,
    required this.otp,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      success: json['success'] ?? false,
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      otp: json['otp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'id': id,
      'email': email,
      'otp': otp,
    };
  }
}
