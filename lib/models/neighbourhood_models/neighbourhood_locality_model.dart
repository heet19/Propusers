import 'dart:convert';

NeighbourhoodResponse neighbourhoodResponseFromJson(String str) =>
    NeighbourhoodResponse.fromJson(json.decode(str));

String neighbourhoodResponseToJson(NeighbourhoodResponse data) =>
    json.encode(data.toJson());

class NeighbourhoodResponse {
  final bool? success;
  final LocalityData? data;

  NeighbourhoodResponse({
    this.success,
    this.data,
  });


  factory NeighbourhoodResponse.fromJson(Map<String, dynamic> json) =>
      NeighbourhoodResponse(
        success: json["success"],
        data: json["data"] != null ? LocalityData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class LocalityData {
  final int? id;
  final String? localityName;
  final String? slug;
  final String? state;
  final String? city;
  final String? division;
  final String? district;
  final String? district_population;
  final String? established;
  final String? coordinates;
  final String? title;
  final String? subtitle;
  final String? area;
  final String? elevation;
  final String? local_time;
  final String? status;
  final int? show_on_page;
  final String? description;
  final String? locality_image;
  final String? created_at;
  final String? updated_at;
  final int? del_status;
  final String? image;
  final List<Point>? points;
  final double? latitude;
  final double? longitude;
  final List<dynamic>? more_localitites;

  LocalityData({
    this.id,
    this.localityName,
    this.slug,
    this.state,
    this.city,
    this.division,
    this.district,
    this.district_population,
    this.established,
    this.coordinates,
    this.title,
    this.subtitle,
    this.area,
    this.elevation,
    this.local_time,
    this.status,
    this.show_on_page,
    this.description,
    this.locality_image,
    this.created_at,
    this.updated_at,
    this.del_status,
    this.image,
    this.points,
    this.latitude,
    this.longitude,
    this.more_localitites,
  });

  factory LocalityData.fromJson(Map<String, dynamic> json) => LocalityData(
    id: json["id"],
    localityName: json["locality_name"],
    slug: json['slug'],
    state: json["state"],
    city: json["city"],
    division: json["division"],
    district: json["district"],
    district_population: json["district_population"],
    established: json["established"],
    coordinates: json["coordinates"],
    title: json["title"],
    subtitle: json["subtitle"],
    area: json["area"],
    elevation: json["elevation"],
    local_time: json["local_time"],
    status: json["status"],
    show_on_page: json["show_on_page"],
    description: json["description"],
    locality_image: json["locality_image"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
    del_status: json["del_status"],
    image: json["image"],
    points: json["points"] != null
        ? List<Point>.from(json["points"].map((x) => Point.fromJson(x)))
        : [],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    more_localitites: json["more_localitites"] != null
        ? List<dynamic>.from(json["more_localitites"].map((x) => x))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locality_name": localityName,
    "slug" : slug,
    "state": state,
    "city": city,
    "division": division,
    "district": district,
    "district_population": district_population,
    "established": established,
    "coordinates": coordinates,
    "title": title,
    "subtitle": subtitle,
    "area": area,
    "elevation": elevation,
    "local_time": local_time,
    "status": status,
    "show_on_page": show_on_page,
    "description": description,
    "locality_image": locality_image,
    "created_at": created_at,
    "updated_at": updated_at,
    "del_status": del_status,
    "image": image,
    "points": points != null
        ? List<dynamic>.from(points!.map((x) => x.toJson()))
        : [],
    "latitude": latitude,
    "longitude": longitude,
    "more_localitites": more_localitites ?? [],
  };
}

class Point {
  final int? id;
  final int? locality_id;
  final int? order;
  final String? title;
  final String? description;
  final String? image_one;
  final String? image_two;
  final String? image_three;
  final String? image_four;
  final int? status;
  final String? created_at;
  final String? updated_at;

  Point({
    this.id,
    this.locality_id,
    this.order,
    this.title,
    this.description,
    this.image_one,
    this.image_two,
    this.image_three,
    this.image_four,
    this.status,
    this.created_at,
    this.updated_at,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    id: json["id"],
    locality_id: json["locality_id"],
    order: json["order"],
    title: json["title"],
    description: json["description"],
    image_one: json["image_one"],
    image_two: json["image_two"],
    image_three: json["image_three"],
    image_four: json["image_four"],
    status: json["status"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locality_id": locality_id,
    "order": order,
    "title": title,
    "description": description,
    "image_one": image_one,
    "image_two": image_two,
    "image_three": image_three,
    "image_four": image_four,
    "status": status,
    "created_at": created_at,
    "updated_at": updated_at,
  };
}
