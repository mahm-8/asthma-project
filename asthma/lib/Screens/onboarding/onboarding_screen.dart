import 'package:asthma/Screens/onboarding/boarding_bottomsheet.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_1.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_3.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_4.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_2.dart';
import 'package:asthma/helper/imports.dart';
import 'package:flutter/material.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

late PageController controller;
int pageIndex = 0;

class _OnboradingScreenState extends State<OnboradingScreen> {
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (value) {
            //add bloc here
            setState(() {
              pageIndex = value;
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page1(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page2(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page3(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page4(),
            ),
          ],
        ),
      ),
      bottomSheet: BoardingBottomsheet(
        pageController: controller,
      ),
    );
  }
}
