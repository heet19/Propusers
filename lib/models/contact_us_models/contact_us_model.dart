import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) =>
    ContactUsModel.fromJson(json.decode(str));

class ContactUsModel {
  Data data;
  List<Title> titles;

  ContactUsModel({
    required this.data,
    required this.titles,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) =>
      ContactUsModel(
        data: Data.fromJson(json["data"]),
        titles: List<Title>.from(
            json["titles"].map((x) => Title.fromJson(x))),
      );
}

class Data {
  String contactInfo;
  String contactAddresses;
  String contactNumbers;
  String contactMails;
  String contactUsBg;
  String link;
  String imageUrl;

  Data({
    required this.contactInfo,
    required this.contactAddresses,
    required this.contactNumbers,
    required this.contactMails,
    required this.contactUsBg,
    required this.link,
    required this.imageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    contactInfo: json["contact_info"],
    contactAddresses: json["contact_addresses"],
    contactNumbers: json["contact_numbers"],
    contactMails: json["contact_mails"],
    contactUsBg: json["contact_us_bg"],
    link: json["link"],
    imageUrl: json["image_url"],
  );
}

class Title {
  int id;
  String title;
  String subtitle;
  String page;
  String section;

  Title({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.section,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    page: json["page"],
    section: json["section"],
  );
}
