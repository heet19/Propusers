import 'dart:convert';

OfficeLocationModel officeLocationModelFromJson(String str) =>
    OfficeLocationModel.fromJson(json.decode(str));

String officeLocationModelToJson(OfficeLocationModel data) =>
    json.encode(data.toJson());

class OfficeLocationModel {
  final bool? success;
  final List<LocationData>? regional;
  final List<LocationData>? headquaters;
  final List<LocationData>? multi;
  final List<TitleSection>? titles;

  OfficeLocationModel({
    this.success,
    this.regional,
    this.headquaters,
    this.multi,
    this.titles,
  });

  factory OfficeLocationModel.fromJson(Map<String, dynamic> json) =>
      OfficeLocationModel(
        success: json["success"],
        regional: json["regional"] != null
            ? List<LocationData>.from(
            json["regional"].map((x) => LocationData.fromJson(x)))
            : [],
        headquaters: json["headquaters"] != null
            ? List<LocationData>.from(
            json["headquaters"].map((x) => LocationData.fromJson(x)))
            : [],
        multi: json["multi"] != null
            ? List<LocationData>.from(
            json["multi"].map((x) => LocationData.fromJson(x)))
            : [],
        titles: json["titles"] != null
            ? List<TitleSection>.from(
            json["titles"].map((x) => TitleSection.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "regional": regional != null
        ? List<dynamic>.from(regional!.map((x) => x.toJson()))
        : [],
    "headquaters": headquaters != null
        ? List<dynamic>.from(headquaters!.map((x) => x.toJson()))
        : [],
    "multi": multi != null
        ? List<dynamic>.from(multi!.map((x) => x.toJson()))
        : [],
    "titles": titles != null
        ? List<dynamic>.from(titles!.map((x) => x.toJson()))
        : [],
  };
}

class LocationData {
  final int? id;
  final String? address;
  final String? type;
  final String? zip;
  final String? city;
  final int? cityId;
  final String? email;
  final String? phone;
  final String? company;
  final String? latitude;
  final String? longitude;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  LocationData({
    this.id,
    this.address,
    this.type,
    this.zip,
    this.city,
    this.cityId,
    this.email,
    this.phone,
    this.company,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    id: json["id"],
    address: json["address"],
    type: json["type"],
    zip: json["zip"],
    city: json["city"],
    cityId: json["city_id"],
    email: json["email"],
    phone: json["phone"],
    company: json["company"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "type": type,
    "zip": zip,
    "city": city,
    "city_id": cityId,
    "email": email,
    "phone": phone,
    "company": company,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
