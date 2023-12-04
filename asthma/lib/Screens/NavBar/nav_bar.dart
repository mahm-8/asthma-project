import 'package:asthma/Screens/HomeScreen/home_screen.dart';
import 'package:asthma/Screens/NavBar/navigator_bar.dart';
import 'package:asthma/Screens/profile/profile.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class NavigatorBarScreen extends StatefulWidget {
  const NavigatorBarScreen({super.key});

  @override
  State<NavigatorBarScreen> createState() => _NavigatorBarScreenState();
}

class _NavigatorBarScreenState extends State<NavigatorBarScreen> {
  int selectedindex = 0;
  List scrren = [const HomeScreen(), Container(), Container(), const Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        height: 60,
        color: ColorPaltte().lightgreentr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: NavigatorBar(
                isSelect: selectedindex == 0 ? true : false,
                icons: Icons.chat_bubble,
                onPressed: () {
                  selectedindex = 0;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: NavigatorBar(
                isSelect: selectedindex == 1 ? true : false,
                icons: Icons.mail,
                onPressed: () {
                  selectedindex = 1;
                  setState(() {});
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: NavigatorBar(
                isSelect: selectedindex == 2 ? true : false,
                icons: Icons.calendar_month_rounded,
                onPressed: () {
                  selectedindex = 2;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: NavigatorBar(
                isSelect: selectedindex == 3 ? true : false,
                icons: Icons.more_horiz,
                onPressed: () {
                  selectedindex = 3;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPaltte().darkBlue,
        foregroundColor: ColorPaltte().white,
        shape: const CircleBorder(),
        onPressed: () {
          // showBottomSheet(
          //     constraints: BoxConstraints(minHeight: 300),
          //     context: context,
          //     builder: (context) => Container());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: scrren[selectedindex],
    );
  }
}
