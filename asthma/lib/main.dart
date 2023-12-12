import 'package:asthma/Screens/chat/chat_screen.dart';
import 'package:asthma/blocs/chat_bloc/chat_bloc.dart';
import 'package:asthma/helper/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SupabaseNetworking().getSupabaseInitialize;
  prefs = await SharedPreferences.getInstance();
  Bloc.observer = MyBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckLoginEvent()),
        ),
        BlocProvider(
            create: (context) => AsthmaBloc()..add(getHospitalDataEvent())),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        buildWhen: (oldState, newState) {
          if (newState is ChangeLanguageState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is ChangeLanguageState) {
            return MaterialApp(
              locale: Locale(state.lang),
              theme: ThemeData(
                useMaterial3: false,
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ar'), // Spanish
              ],
              home: const LoadingScreen(),
            );
          }
          return MaterialApp(
            locale: const Locale('en'),
            theme: ThemeData(
                useMaterial3: false,
                scaffoldBackgroundColor: ColorPaltte().newDarkBlue),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Spanish
            ],
            home: const LoadingScreen(),
          );
        },
      ),
    );
  }
}
