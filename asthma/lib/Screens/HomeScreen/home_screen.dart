import 'dart:convert';
import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Screens/HomeScreen/widgets/air_quality.dart';
import 'package:asthma/Screens/HomeScreen/widgets/medication_reminder.dart';
import 'package:asthma/Screens/HomeScreen/widgets/nerest_hospital.dart';
import 'package:asthma/Screens/symptoms/add_symptoms_screen.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../Services/networking_request.dart';

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

  Position? currentLocation;
  List<LocationModel> nearestLocations = [];
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getUserProfile();
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
    final country = 'AR';
    final city = 'Buenos Aires';
    final airQualityData = await airQualityMethod(country, city);
  }

  findNearestLocations() {
    if (currentLocation != null) {
      nearestLocations = [];
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    SupabaseServer().getHospitalData();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 240,
            width: context.getWidth(),
            decoration: BoxDecoration(
                color: ColorPaltte().newDarkBlue,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: ColorPaltte().white),
                          ),
                          Text(
                            'Wadha',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: ColorPaltte().darkBlue),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ClipOval(
                        child: Image.asset(
                          'lib/assets/images/image.jpg',
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const AirQuality(),
                  const SizedBox(
                    height: 20,
                  ),
                  const MedicationReminder(),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 75,
                    width: context.getWidth(),
                    child: InkWell(
                      onTap: () {
                        context.push(view: const AddSymptomsScreen());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: ColorPaltte().newDarkBlue,
                        child: const Center(
                            child: Text(
                          'Add Symptoms',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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