import 'package:asthma/constants/globals.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: ColorPaltte().lightgreen,
            height: 40,
            width: 100,
          ),
          Container(
            color: ColorPaltte().darkBlue,
            height: 40,
            width: 100,
          ),
          Container(
            color: ColorPaltte().darkGreen,
            height: 40,
            width: 100,
          ),
          Container(
            color: ColorPaltte().lightBlue,
            height: 40,
            width: 100,
          ),
        ],
      ),
    );
  }
}
