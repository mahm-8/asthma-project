import 'package:asthma/Screens/HomeScreen/widgets/drawer.dart';
import 'package:asthma/Screens/chat/chat_screen.dart';
import 'package:asthma/blocs/chat_bloc/chat_bloc.dart';
import 'package:asthma/helper/imports.dart';
import 'widgets/home_custom_app_bar.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
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
                          Text(
                            '${AppLocalizations.of(context)!.welcome}, ',
                            style: TextStyle().titleFontwhite,
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
                                bloc.user?.name ?? "",
                                style: const TextStyle().titleFont,
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
                            BlocListener<ChatBloc, ChatState>(
                              listener: (context, state) {
                                if (state is GetAdminSuccessedState) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                user: state.admin.first,
                                              )));
                                }
                              },
                              child: ContainerWidget(
                                imageurl: 'lib/assets/images/Chatbot-pana.png',
                                title: AppLocalizations.of(context)!.helper,
                                onTap: () {
                                  context
                                      .read<ChatBloc>()
                                      .add(GetAdminChatEvent());
                                },
                              ),
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
                      NerestHospital(),
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
