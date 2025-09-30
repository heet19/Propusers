import 'dart:convert';

PrivacyPolicyTermsAndConditionsModel privacyPolicyTermsAndConditionsModelFromJson(String str) =>
    PrivacyPolicyTermsAndConditionsModel.fromJson(json.decode(str));

class PrivacyPolicyTermsAndConditionsModel {
  int id;
  String pageName;
  String content;
  int status;
  int deleteStatus;
  String createdAt;
  String updatedAt;

  PrivacyPolicyTermsAndConditionsModel({
    required this.id,
    required this.pageName,
    required this.content,
    required this.status,
    required this.deleteStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PrivacyPolicyTermsAndConditionsModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyTermsAndConditionsModel(
        id: json["data"]["id"],
        pageName: json["data"]["page_name"],
        content: json["data"]["content"],
        status: json["data"]["status"],
        deleteStatus: json["data"]["delete_status"],
        createdAt: json["data"]["created_at"],
        updatedAt: json["data"]["updated_at"],
      );
}
