import 'package:asthma/helper/imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://api.openaq.org/v1/measurements';
double? value = 0.0;

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
    context.read<AsthmaBloc>().add(getHospitalDataEvent());
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

    // final country = 'AR';
    // final city = 'Buenos Aires';
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLocation!.latitude,
      currentLocation!.longitude,
    );
    await airQualityMethod(
        placemarks.first.isoCountryCode!, placemarks.first.administrativeArea!);
  }

  Future findNearestLocations() async {
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
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Container(
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
                    child: Image.network(bloc.user!.image!),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  context.push(view: const HomeScreen());
                },
                leading: const Icon(Icons.home_outlined),
                title: Text(AppLocalizations.of(context)!.home),
              ),
              ListTile(
                onTap: () {
                  context.push(view: const BreathingScreen());
                },
                leading: const Icon(Icons.spa_outlined),
                title: Text(AppLocalizations.of(context)!.breathing),
              ),
              ListTile(
                onTap: () {
                  context.push(view: Profile());
                },
                leading: const Icon(Icons.person_outline_outlined),
                title: Text(AppLocalizations.of(context)!.profile),
              ),
              ListTile(
                onTap: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  showDialog(
                      context: context,
                      builder: (context) => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ));
                },
                leading: const Icon(Icons.login_outlined),
                title: Text(AppLocalizations.of(context)!.logout),
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
              height: context.getHeight() * 0.29,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.welcome}, ',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: ColorPaltte().newlightBlue),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          buildWhen: (oldState, newState) {
                            if (newState is LoadState) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            return Text(
                              bloc.user!.name ?? "",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 16,
                        children: [
                          ContainerWidget(
                            imageurl: 'lib/assets/images/Chatbot-pana.png',
                            title: AppLocalizations.of(context)!.helper,
                            onTap: () {
                              context.push(view: const ChatGPT());
                            },

                            // const MedicationReminder(),
                          ),
                          ContainerWidget(
                            imageurl:
                                'lib/assets/images/Breathingexercise-rafiki1.png',
                            title: AppLocalizations.of(context)!.breathing,
                            onTap: () {
                              context.push(view: const BreathingScreen());
                            },
                          ),
                          ContainerWidget(
                            imageurl: 'lib/assets/images/Inhaller1-bro.png',
                            title: AppLocalizations.of(context)!.medicine,
                            onTap: () {
                              context.push(
                                  view: const MedicationTrackerScreen());
                            },
                          ),
                          ContainerWidget(
                            imageurl: 'lib/assets/images/Asymptomatic-bro.png',
                            title: AppLocalizations.of(context)!.symptom,
                            onTap: () {
                              context.push(view: const SymptomTrackerScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(context)!.nearest,
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
