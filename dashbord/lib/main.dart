import 'package:dashboard/bloc/auth_bloc/auth_bloc.dart';
import 'package:dashboard/bloc/chat_bloc/chat_bloc.dart';
import 'package:dashboard/bloc/task_bloc.dart';
import 'package:dashboard/bloc/user_bloc/user_bloc.dart';
import 'package:dashboard/screens/loading/loading_screen.dart';
import 'package:dashboard/services/networking_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SupabaseNetworking().getSupabaseInitialize;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => TaskBloc()..add(getTaskEvent()),
        ),
      ],
      child: MaterialApp(
        locale: Locale('en'),
        home: LoadingScreen(),
        theme: ThemeData(
          datePickerTheme: const DatePickerThemeData(
            confirmButtonStyle: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                    TextStyle(color: Color(0xff146C94)))),
            todayForegroundColor: MaterialStatePropertyAll(Color(0xff146C94)),
            backgroundColor: Color.fromARGB(255, 149, 192, 212),
            // Color.fromARGB(255, 149, 192, 212)
            cancelButtonStyle: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                TextStyle(color: Colors.transparent),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), // Spanish
        ],
      ),
    );
  }
}
