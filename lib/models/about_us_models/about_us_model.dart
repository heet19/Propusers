import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) =>
    AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) =>
    json.encode(data.toJson());

class AboutUsModel {
  final bool? succes;
  final AboutSection? about;
  final AboutSection? ourMission;
  final AboutSection? ourVision;
  final TopProprenuer? topProprenuer;
  final List<TitleSection>? titles;

  AboutUsModel({
    this.succes,
    this.about,
    this.ourMission,
    this.ourVision,
    this.topProprenuer,
    this.titles,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) =>
      AboutUsModel(
        succes: json["succes"],
        about: json["about"] != null ? AboutSection.fromJson(json["about"]) : null,
        ourMission: json["our_mission"] != null ? AboutSection.fromJson(json["our_mission"]) : null,
        ourVision: json["our_vision"] != null ? AboutSection.fromJson(json["our_vision"]) : null,
        topProprenuer: json["top_proprenuer"] != null
            ? TopProprenuer.fromJson(json["top_proprenuer"])
            : null,
        titles: json["titles"] != null
            ? List<TitleSection>.from(
            json["titles"].map((x) => TitleSection.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "succes": succes,
    "about": about?.toJson(),
    "our_mission": ourMission?.toJson(),
    "our_vision": ourVision?.toJson(),
    "top_proprenuer": topProprenuer?.toJson(),
    "titles": titles != null
        ? List<dynamic>.from(titles!.map((x) => x.toJson()))
        : [],
  };
}

class AboutSection {
  final int? id;
  final int? secId;
  final String? title;
  final String? description;
  final String? subtitle;
  final String? name;
  final String? designation;
  final String? bgImg;
  final String? img;
  final String? createdAt;
  final String? updatedAt;
  final List<String>? images;

  AboutSection({
    this.id,
    this.secId,
    this.title,
    this.description,
    this.subtitle,
    this.name,
    this.designation,
    this.bgImg,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory AboutSection.fromJson(Map<String, dynamic> json) => AboutSection(
    id: json["id"],
    secId: json["sec_id"],
    title: json["title"],
    description: json["description"],
    subtitle: json["subtitle"],
    name: json["name"],
    designation: json["designation"],
    bgImg: json["bg_img"],
    img: json["img"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    images: json["images"] != null
        ? List<String>.from(json["images"].map((x) => x))
        : (json["image"] != null
        ? List<String>.from(json["image"].map((x) => x))
        : []),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sec_id": secId,
    "title": title,
    "description": description,
    "subtitle": subtitle,
    "name": name,
    "designation": designation,
    "bg_img": bgImg,
    "img": img,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "images": images ?? [],
  };
}

class TopProprenuer {
  final int? id;
  final int? secId;
  final String? title;
  final String? description;
  final String? subtitle;
  final String? name;
  final String? designation;
  final String? bgImg;
  final String? img;
  final String? createdAt;
  final String? updatedAt;
  final List<Proprenuer>? proprenuers;

  TopProprenuer({
    this.id,
    this.secId,
    this.title,
    this.description,
    this.subtitle,
    this.name,
    this.designation,
    this.bgImg,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.proprenuers,
  });

  factory TopProprenuer.fromJson(Map<String, dynamic> json) => TopProprenuer(
    id: json["id"],
    secId: json["sec_id"],
    title: json["title"],
    description: json["description"],
    subtitle: json["subtitle"],
    name: json["name"],
    designation: json["designation"],
    bgImg: json["bg_img"],
    img: json["img"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    proprenuers: json["proprenuers"] != null
        ? List<Proprenuer>.from(
        json["proprenuers"].map((x) => Proprenuer.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sec_id": secId,
    "title": title,
    "description": description,
    "subtitle": subtitle,
    "name": name,
    "designation": designation,
    "bg_img": bgImg,
    "img": img,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "proprenuers": proprenuers != null
        ? List<dynamic>.from(proprenuers!.map((x) => x.toJson()))
        : [],
  };
}

class Proprenuer {
  final int? id;
  final String? name;
  final String? slug;
  final String? address;
  final String? email;
  final String? description;
  final String? imageUrl;

  Proprenuer({
    this.id,
    this.name,
    this.slug,
    this.address,
    this.email,
    this.description,
    this.imageUrl,
  });

  factory Proprenuer.fromJson(Map<String, dynamic> json) => Proprenuer(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    address: json["address"],
    email: json["email"],
    description: json["description"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "address": address,
    "email": email,
    "description": description,
    "image_url": imageUrl,
  };
}

class TitleSection {
  final int? id;
  final String? title;
  final String? subtitle;
  final String? page;
  final String? section;

  TitleSection({
    this.id,
    this.title,
    this.subtitle,
    this.page,
    this.section,
  });

  factory TitleSection.fromJson(Map<String, dynamic> json) => TitleSection(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    page: json["page"],
    section: json["section"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "page": page,
    "section": section,
  };
}
