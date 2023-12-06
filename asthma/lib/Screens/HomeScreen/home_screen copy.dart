import 'dart:convert';
import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Screens/HomeScreen/widgets/air_quality.dart';
import 'package:asthma/Screens/HomeScreen/widgets/medication_reminder.dart';
import 'package:asthma/Screens/HomeScreen/widgets/nerest_hospital.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://api.openaq.org/v1/measurements';
double? value;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  airQualityMethod(String country, String city) async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl?country=$country&city=$city'));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'][0]['value'];
        value = results;
        print('$value');
        return results;
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  List<Location> locations = [
    Location(
        latitude: 24.711517493335617,
        longitude: 46.67436749233474,
        name: 'Kingdom Centre'),
    Location(
        latitude: 24.74308571150349,
        longitude: 46.67918719436232,
        name: 'Hayat Mall'),
    Location(
        latitude: 24.559035517748324,
        longitude: 46.63795466736618,
        name: 'Salam Mall'),
    Location(
        latitude: 24.692604330125604,
        longitude: 46.66943633484204,
        name: 'Hayat Mall'),
    Location(
        latitude: 24.692604330125604,
        longitude: 46.66943633484204,
        name: 'Panorama Mall'),
    Location(
        latitude: 24.69611438141796,
        longitude: 46.72863692503346,
        name: 'The View Mall'),
  ];
  Position? currentLocation;
  List<Location> nearestLocations = [];
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = position;
        print(currentLocation);
        findNearestLocations();
      });
    } catch (e) {
      print(e);
    }
    final country = 'CA';
    final city = 'Toronto';
    final airQualityData = await airQualityMethod(country, city);
  }

  findNearestLocations() {
    if (currentLocation != null) {
      nearestLocations = [];
      for (var location in locations) {
        double distance = Geolocator.distanceBetween(
          currentLocation!.latitude,
          currentLocation!.longitude,
          location.latitude,
          location.longitude,
        );
        location.distance = distance;
        nearestLocations.add(location);
      }
      nearestLocations.sort((a, b) => a.distance.compareTo(b.distance));
      nearestLocations = nearestLocations.take(5).toList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 260,
            width: context.getWidth(),
            decoration: BoxDecoration(
                color: ColorPaltte().lightBlue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'lib/assets/images/image.jpg',
                          width: 70,
                          height: 70,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome,',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey),
                          ),
                          Text(
                            'Wadha',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: ColorPaltte().darkBlue),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AirQuality(),
                  const SizedBox(
                    height: 20,
                  ),
                  MedicationReminder(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Nearest Hospital ',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: ColorPaltte().darkBlue),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NerestHospital(nearestLocations: nearestLocations),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
