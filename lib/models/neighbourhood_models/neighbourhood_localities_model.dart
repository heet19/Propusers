import 'dart:convert';

NeighbourhoodLocalitiesModel NeighbourhoodLocalitiesModelFromJson(String str) {
  final jsonData = json.decode(str);
  return NeighbourhoodLocalitiesModel.fromJson(jsonData);
}

String NeighbourhoodLocalitiesModelToJson(NeighbourhoodLocalitiesModel model) {
  final data = model.toJson();
  return json.encode(data);
}

class NeighbourhoodLocalitiesModel {
  final bool success;
  final List<LocalitiesData> data;
  final CityData? cityData;

  NeighbourhoodLocalitiesModel({
    required this.success,
    required this.data,
    this.cityData,
  });

  factory NeighbourhoodLocalitiesModel.fromJson(Map<String, dynamic> json) =>
      NeighbourhoodLocalitiesModel(
        success: json['success'] ?? false,
        data: json['data'] == null
            ? []
            : List<LocalitiesData>.from(
            json['data'].map((x) => LocalitiesData.fromJson(x))),
        cityData: json['city_data'] != null
            ? CityData.fromJson(json['city_data'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

}

class CityData {
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

  CityData({
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

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
    id: json['id'] ?? 0,
    city_name: json['city_name'] ?? "",
    slug: json['slug'] ?? "",
    city_image: json['city_image'] ?? "",
    show_on_page: json['show_on_page'] ?? "0",
    show_on_locality: json['show_on_locality'] ?? 0,
    neighbourhood_sequence: json['neighbourhood_sequence'] ?? 0,
    city_status: json['city_status'] ?? "0",
    state: json['state'] ?? 0,
    created_at: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    updated_at: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    del_status: json['del_status'] ?? 0,
    lat: _toDouble(json['lat']),
    lng: _toDouble(json['lng']),
  );

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

}

class LocalitiesData {
  final int id;
  final String locality_name;
  final String slug;
  final int state;
  final String city;
  final String division;
  final String district;
  final String district_population;
  final String established;
  final String coordinates;
  final dynamic title;
  final dynamic subtitle;
  final String area;
  final String elevation;
  final String local_time;
  final String status;
  final int show_on_page;
  final String description;
  final String locality_image;
  final DateTime created_at;
  final DateTime updated_at;
  final int del_status;
  final String city_name;
  final double latitude;
  final double logitude;
  final String image;

  LocalitiesData({
    required this.id,
    required this.locality_name,
    required this.slug,
    required this.state,
    required this.city,
    required this.division,
    required this.district,
    required this.district_population,
    required this.established,
    required this.coordinates,
    this.title,
    this.subtitle,
    required this.area,
    required this.elevation,
    required this.local_time,
    required this.status,
    required this.show_on_page,
    required this.description,
    required this.locality_image,
    required this.created_at,
    required this.updated_at,
    required this.del_status,
    required this.city_name,
    required this.latitude,
    required this.logitude,
    required this.image,
  });

  factory LocalitiesData.fromJson(Map<String, dynamic> json) => LocalitiesData(
    id: json['id'] ?? 0,
    locality_name: json['locality_name'] ?? "",
    slug: json['slug'] ?? "",
    state: json['state'] ?? 0,
    city: json['city'] ?? "",
    division: json['division'] ?? "",
    district: json['district'] ?? "",
    district_population: json['district_population'] ?? "",
    established: json['established'] ?? "",
    coordinates: json['coordinates'] ?? "",
    title: json['title'],
    subtitle: json['subtitle'],
    area: json['area'] ?? "",
    elevation: json['elevation'] ?? "",
    local_time: json['local_time'] ?? "",
    status: json['status'] ?? "",
    show_on_page: json['show_on_page'] ?? 0,
    description: json['description'] ?? "",
    locality_image: json['locality_image'] ?? "",
    created_at: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    updated_at: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    del_status: json['del_status'] ?? 0,
    city_name: json['city_name'] ?? "",
    latitude: _toDouble(json['latitude']),
    logitude: _toDouble(json['logitude']),
    image: json['image'] ?? "",
  );

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "locality_name": locality_name,
    "slug": slug,
    "city_name": city_name,
    "image": image,
    "latitude": latitude,
    "logitude": logitude,
  };
}
