import 'package:asthma/Screens/HomeScreen/home_screen.dart';
import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/Screens/auth/signup_screen.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavigatorBarScreen(),
      ),
    );
  }
}
