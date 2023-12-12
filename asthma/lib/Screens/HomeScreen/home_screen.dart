
import 'package:asthma/Screens/HomeScreen/widgets/drawer.dart';
import 'package:asthma/Screens/HomeScreen/widgets/location_functions.dart';
import 'package:asthma/helper/imports.dart';
import 'widgets/home_custom_app_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getUserProfile();
    context.read<AsthmaBloc>().add(getHospitalDataEvent());
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();

    return DrawerMainWidget(
        drawerController: _advancedDrawerController,
        bloc: bloc,
        drawerChild: Scaffold(
          appBar: homeCustomAppBar(
              controller: _advancedDrawerController,
              onPress: () {
                _handleMenuButtonPressed();
              }),
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
// <<<<<<< Ruba-AlHilal
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
// =======
//                           ContainerWidget(
//                             imageurl: 'lib/assets/images/Chatbot-pana.png',
//                             title: AppLocalizations.of(context)!.helper,
//                             onTap: () {
//                               context.push(view: const ChatGPT());
//                             },

//                             // const MedicationReminder(),
//                           ),
//                           ContainerWidget(
//                             imageurl:
//                                 'lib/assets/images/Breathingexercise-rafiki1.png',
//                             title: AppLocalizations.of(context)!.breathing,
//                             onTap: () {
//                               context.push(view: const BreathingScreen());
//                             },
//                           ),
//                           ContainerWidget(
//                             imageurl: 'lib/assets/images/Inhaller1-bro.png',
//                             title: AppLocalizations.of(context)!.medicine,
//                             onTap: () {
//                               context.push(
//                                   view: const MedicationTrackerScreen());
//                             },
//                           ),
//                           ContainerWidget(
//                             imageurl: 'lib/assets/images/Asymptomatic-bro.png',
//                             title: AppLocalizations.of(context)!.symptom,
//                             onTap: () {
//                               context.push(view: const SymptomTrackerScreen());
// >>>>>>> main
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
                              imageurl:
                                  'lib/assets/images/Asymptomatic-bro.png',
                              title: AppLocalizations.of(context)!.symptom,
                              onTap: () {
                                context.push(
                                    view: const SymptomTrackerScreen());
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
        ));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
