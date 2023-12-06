import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:flutter/material.dart';

void main() async{
 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigatorBarScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
    );
  }
}
