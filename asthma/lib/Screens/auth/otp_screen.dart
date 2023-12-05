import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/screen_dimensions.dart';

import 'package:asthma/extensions/text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorPaltte().darkBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              child: Center(
                  child: Image.asset(
                color: Colors.white,
                "assets/mail.png",
                height: 150,
                width: 150,
              )),
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Colors.white),
              height: context.getHeight(divide: 1.5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "verification code",
                    style: const TextStyle().bold24,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Pinput(
                    autofocus: true,
                    length: 4,
                    onCompleted: (pin) {
                      context.pushAndRemoveUntil(
                          view: const NavigatorBarScreen());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
