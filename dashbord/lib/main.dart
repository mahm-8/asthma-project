import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          datePickerTheme: const DatePickerThemeData(
              confirmButtonStyle: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                      TextStyle(color: Color(0xff146C94)))),
              todayForegroundColor: MaterialStatePropertyAll(Color(0xff146C94)),
              backgroundColor: Color.fromARGB(255, 149, 192, 212),
              cancelButtonStyle: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                      TextStyle(color: Colors.transparent))))),
    );
  }
}
