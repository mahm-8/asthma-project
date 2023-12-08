import 'dart:convert';
import 'package:asthma/Models/location_model.dart';
import 'package:asthma/Screens/HomeScreen/widgets/air_quality.dart';
import 'package:asthma/Screens/HomeScreen/widgets/medication_reminder.dart';
import 'package:asthma/Screens/HomeScreen/widgets/nerest_hospital.dart';
import 'package:asthma/Screens/breathing/breathing_screen.dart';
import 'package:asthma/Screens/chatGPT/chat_gpt.dart';
import 'package:asthma/Screens/profile/profile.dart';
import 'package:asthma/Screens/symptoms/add_symptoms_screen.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/blocs/user_bloc/user_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    SupabaseServer().getHospitalData();
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/flutter_logo.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    context.push(view: HomeScreen());
                  },
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Home'),
                ),
                ListTile(
                  onTap: () {
                    context.push(view: BreathingScreen());
                  },
                  leading: const Icon(Icons.spa_outlined),
                  title: const Text('Breathing'),
                ),
                ListTile(
                  onTap: () {
                    context.push(view: ChatGPT());
                  },
                  leading: const Icon(Icons.chat_bubble_outline_outlined),
                  title: const Text('ChatGPT'),
                ),
                ListTile(
                  onTap: () {
                    context.push(view: Profile());
                  },
                  leading: const Icon(Icons.person_outline_outlined),
                  title: const Text('Profile'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPaltte().newDarkBlue,
          elevation: 0,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: context.getHeight() * 0.14,
              width: context.getWidth(),
              decoration: BoxDecoration(
                  color: ColorPaltte().newDarkBlue,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome, ',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: ColorPaltte().newlightBlue),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            return Text(
                              'bloc.user!.name!',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: ColorPaltte().darkBlue),
                            );
                          },
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
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
