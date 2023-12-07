class LocationModel {
  double? latitude;
  double? longitude;
  String? name;
  double? distance;
  int? id;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.distance = 0.0,
  });
  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    distance = json['distance'];
  }
}
