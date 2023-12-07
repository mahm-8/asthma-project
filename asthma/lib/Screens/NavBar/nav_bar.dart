import 'package:asthma/Screens/HomeScreen/home_screen.dart';
import 'package:asthma/Screens/breathing/breathing_screen.dart';
import 'package:asthma/Screens/chatGPT/chat_gpt.dart';
import 'package:asthma/Screens/profile/profile.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class NavigatorBarScreen extends StatefulWidget {
  const NavigatorBarScreen({super.key});

  @override
  State<NavigatorBarScreen> createState() => _NavigatorBarScreenState();
}

class _NavigatorBarScreenState extends State<NavigatorBarScreen> {
  List screen = [const HomeScreen(), BreathingScreen(), const ChatGPT(), const Profile()];
  late int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorPaltte().darkBlue,
        unselectedItemColor: ColorPaltte().lightBlue,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.access_alarms_rounded),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
