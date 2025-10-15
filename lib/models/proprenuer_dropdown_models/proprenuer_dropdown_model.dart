import 'dart:convert';

ProprenuerDropdownModel proprenuerDropdownModelFromJson(String str) =>
    ProprenuerDropdownModel.fromJson(json.decode(str));

class ProprenuerDropdownModel {
  bool success;
  Data data;

  ProprenuerDropdownModel({
    required this.success,
    required this.data,
  });

  factory ProprenuerDropdownModel.fromJson(Map<String, dynamic> json) =>
      ProprenuerDropdownModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  List<StateModel> states;
  List<CityModel> cities;
  List<DropdownNeighbourhoodModel> neighbourhoods;

  Data({
    required this.states,
    required this.cities,
    required this.neighbourhoods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    states: List<StateModel>.from(
        json["states"].map((x) => StateModel.fromJson(x))),
    cities: List<CityModel>.from(
        json["cities"].map((x) => CityModel.fromJson(x))),
    neighbourhoods: List<DropdownNeighbourhoodModel>.from(
        json["neighbourhoods"].map((x) => DropdownNeighbourhoodModel.fromJson(x))),
  );
}

class StateModel {
  int id;
  String stateName;

  StateModel({
    required this.id,
    required this.stateName,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json["id"],
    stateName: json["state_name"],
  );
}

class CityModel {
  int id;
  String cityName;

  CityModel({
    required this.id,
    required this.cityName,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    cityName: json["city_name"],
  );
}

class DropdownNeighbourhoodModel {
  int id;
  String localityName;

  DropdownNeighbourhoodModel({
    required this.id,
    required this.localityName,
  });

  factory DropdownNeighbourhoodModel.fromJson(Map<String, dynamic> json) =>
      DropdownNeighbourhoodModel(
        id: json["id"],
        localityName: json["locality_name"],
      );
}
