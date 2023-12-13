import 'package:asthma/helper/imports.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://api.openaq.org/v1/measurements';
Position? currentLocation;
List<LocationModel> nearestLocations = [];
double? value = 1.9;

airQualityMethod(String country, String city) async {
  try {
    final response =
        await http.get(Uri.parse('$apiUrl?country=$country&city=$city'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'][0]['value'];
      value = results;
      return results;
    }
  } catch (error) {
    return [];
  }
}

Future<void> getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = position;
    // findNearestLocations();
  } catch (e) {
    print(e);
  }

  final country = 'AR';
  final city = 'Buenos Aires';
  // List<Placemark> placemarks = await placemarkFromCoordinates(
  //   currentLocation!.latitude,
  //   currentLocation!.longitude,
  // );
  // await airQualityMethod(
  //     placemarks.first.isoCountryCode!, placemarks.first.administrativeArea!);
}

Future findNearestLocations() async {
  if (currentLocation != null) {
    for (var location in allHospetal) {
      double distance = Geolocator.distanceBetween(
        currentLocation!.latitude,
        currentLocation!.longitude,
        location.latitude!,
        location.longitude!,
      );
      location.distance = distance;
      nearestLocations.add(location);
    }

    nearestLocations.sort((a, b) => a.distance!.compareTo(b.distance!));
    nearestLocations = nearestLocations.take(5).toList();
  }
}
