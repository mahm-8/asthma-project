import 'package:asthma/blocs/chat_bloc/chat_bloc.dart';
import 'package:asthma/helper/imports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SupabaseNetworking().getSupabaseInitialize;
  Bloc.observer = MyBlocObserver();
  prefs =await SharedPreferences.getInstance();
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
        BlocProvider(create: (context) => AsthmaBloc()),
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
                textTheme: GoogleFonts.tajawalTextTheme(
                  Theme.of(context).textTheme,
                ),
                useMaterial3: false,
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              home: const LoadingScreen(),
            );
          }
          return MaterialApp(
            locale: const Locale('en'),
            theme: ThemeData(
              textTheme: GoogleFonts.tajawalTextTheme(
                Theme.of(context).textTheme,
              ),
              useMaterial3: false,
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            home: const LoadingScreen(),
          );
        },
      ),
    );
  }
}
