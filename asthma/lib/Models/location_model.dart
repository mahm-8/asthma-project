class Location {
  final double latitude;
  final double longitude;
  final String name;
  double distance;

  Location({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.distance = 0.0,
  });
}