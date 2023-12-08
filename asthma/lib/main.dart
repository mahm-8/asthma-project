import 'package:asthma/Screens/Data_Symptoms_Screen/data_ymptoms_screen.dart';
import 'package:asthma/Screens/auth/signup_screen.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Services/networking_api.dart';
import 'blocs/user_bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SupabaseNetworking().getSupabaseInitialize;
  SupabaseNetworking().getSupabase;
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
            create: (context) => AsthmaBloc()..add(getHospitalDataEvent())),
        BlocProvider(
          create: (context) => UserBloc()..add(LoadUserData()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SymptomTrackerScreen(),
        theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}
