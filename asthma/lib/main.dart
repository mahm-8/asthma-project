import 'package:asthma/Screens/Data_Symptoms_Screen/data_ymptoms_screen.dart';
import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/Services/supabase_service.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';

import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await supabaseConfig();
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
          create: (context) => AsthmaBloc()..add(getHospitalDataEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const NavigatorBarScreen(),
        theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}
