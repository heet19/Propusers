import 'dart:convert';

PropreneurExperienceModel propreneurExperienceModelFromJson(String str) =>
    PropreneurExperienceModel.fromJson(json.decode(str));

class PropreneurExperienceModel {
  bool success;
  Data data;

  PropreneurExperienceModel({
    required this.success,
    required this.data,
  });

  factory PropreneurExperienceModel.fromJson(Map<String, dynamic> json) =>
      PropreneurExperienceModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Section first;
  Section second;
  Section third;
  Section fourth;
  Section fifth;
  Section sixth;
  Section seventh;

  Data({
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    first: Section.fromJson(json["first"]),
    second: Section.fromJson(json["second"]),
    third: Section.fromJson(json["third"]),
    fourth: Section.fromJson(json["fourth"]),
    fifth: Section.fromJson(json["fifth"]),
    sixth: Section.fromJson(json["sixth"]),
    seventh: Section.fromJson(json["seventh"]),
  );
}

class Section {
  int id;
  String title;
  String? description;
  String subtitle;
  String? name;
  String? designation;
  String? bgImg;
  String? img;
  String? video;
  String createdAt;
  String updatedAt;
  List<Feature>? features;

  Section({
    required this.id,
    required this.title,
    this.description,
    required this.subtitle,
    this.name,
    this.designation,
    this.bgImg,
    this.img,
    this.video,
    required this.createdAt,
    required this.updatedAt,
    this.features,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    subtitle: json["subtitle"],
    name: json["name"],
    designation: json["designation"],
    bgImg: json["bg_img"],
    img: json["img"],
    video: json["video"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    features: json["features"] == null
        ? null
        : List<Feature>.from(
        json["features"].map((x) => Feature.fromJson(x))),
  );
}

class Feature {
  int id;
  int secId;
  int sequence;
  String title;
  String subtitle;
  String? content;
  String? image;
  String? icon;
  String createdAt;
  String updatedAt;

  Feature({
    required this.id,
    required this.secId,
    required this.sequence,
    required this.title,
    required this.subtitle,
    this.content,
    this.image,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"],
    secId: json["sec_id"],
    sequence: json["sequence"],
    title: json["title"],
    subtitle: json["subtitle"],
    content: json["content"],
    image: json["image"],
    icon: json["icon"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}
