import 'package:asthma/helper/imports.dart';

class DrawerMainWidget extends StatelessWidget {
  DrawerMainWidget(
      {super.key,
      required this.drawerChild,
      required this.drawerController,
      required this.bloc});

  final Widget drawerChild;
  final AdvancedDrawerController drawerController;
  final UserBloc bloc;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      rtlOpening: AppLocalizations.of(context)!.welcome == "مرحبا",
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 116, 187, 223),
              Colors.blueGrey.withOpacity(0.3)
            ],
          ),
        ),
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
                    child: Image.network(
                      bloc.user!.image!,
                      fit: BoxFit.cover,
                    ),
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
                  fontSize: 18,
                  color: Colors.white30,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text(
                    'Terms of Service | Privacy Policy',
                    style: const TextStyle().drawerTerm,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: drawerChild,
    );
  }
}
