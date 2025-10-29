class SignInModel {
  final int id;
  final String name;
  final String email;
  final String contact;
  final int status;
  final String userType;
  final String? profilePic;

  SignInModel({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.status,
    required this.userType,
    this.profilePic,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      status: json['status'] ?? 0,
      userType: json['user_type'] ?? '',
      profilePic: json['profile_pic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact': contact,
      'status': status,
      'user_type': userType,
      'profile_pic': profilePic,
    };
  }
}
