import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/Screens/breathing/breathing_screen.dart';
import 'package:asthma/Screens/medication/add_medication_screen.dart';
import 'package:asthma/Screens/symptoms/add_symptoms_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddMedicationScreen(),
    );
  }
}
