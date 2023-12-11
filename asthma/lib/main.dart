import 'package:asthma/Screens/loading/loading_screen.dart';
import 'package:asthma/blocs/language_bloc/language_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Services/networking_api.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'helper/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SupabaseNetworking().getSupabaseInitialize;
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
