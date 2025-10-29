import 'dart:convert';

NeighbourhoodModel neighbourhoodModelFromJson(String str) =>
    NeighbourhoodModel.fromJson(json.decode(str));

class NeighbourhoodModel {
  final bool success;
  final List<NeighbourhoodData> data;
  final List<NeighbourhoodTitle> titles;

  NeighbourhoodModel({
    required this.success,
    required this.data,
    required this.titles,
  });

  factory NeighbourhoodModel.fromJson(Map<String, dynamic> json) =>
      NeighbourhoodModel(
        success: json["success"] ?? false,
        data: json["data"] == null
            ? []
            : List<NeighbourhoodData>.from(
            json["data"].map((x) => NeighbourhoodData.fromJson(x))),
        titles: json["titles"] == null
            ? []
            : List<NeighbourhoodTitle>.from(
            json["titles"].map((x) => NeighbourhoodTitle.fromJson(x))),
      );
}

class NeighbourhoodTitle {
  final int id;
  final String title;
  final String subtitle;
  final String page;
  final String section;

  NeighbourhoodTitle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.section,
  });

  factory NeighbourhoodTitle.fromJson(Map<String, dynamic> json) =>
      NeighbourhoodTitle(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        subtitle: json["subtitle"] ?? "",
        page: json["page"] ?? "",
        section: json["section"] ?? "",
      );
}

class NeighbourhoodData {
  final int id;
  final String city_name;
  final String slug;
  final String city_image;
  final String show_on_page;
  final int show_on_locality;
  final int neighbourhood_sequence;
  final String city_status;
  final int state;
  final DateTime created_at;
  final DateTime updated_at;
  final int del_status;
  final double lat;
  final double lng;

  NeighbourhoodData({
    required this.id,
    required this.city_name,
    required this.slug,
    required this.city_image,
    required this.show_on_page,
    required this.show_on_locality,
    required this.neighbourhood_sequence,
    required this.city_status,
    required this.state,
    required this.created_at,
    required this.updated_at,
    required this.del_status,
    required this.lat,
    required this.lng,
  });

  factory NeighbourhoodData.fromJson(Map<String, dynamic> json) =>
      NeighbourhoodData(
        id: json["id"] ?? 0,
        city_name: json["city_name"] ?? "",
        slug: json["slug"] ?? "",
        city_image: json["city_image"] ?? "",
        show_on_page: json["show_on_page"] ?? "0",
        show_on_locality: json["show_on_locality"] ?? 0,
        neighbourhood_sequence: json["neighbourhood_sequence"] ?? 0,
        city_status: json["city_status"] ?? "0",
        state: json["state"] ?? 0,
        created_at: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updated_at: DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
        del_status: json["del_status"] ?? 0,
        lat: _toDouble(json["lat"]),
        lng: _toDouble(json["lng"]),
      );

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

}
