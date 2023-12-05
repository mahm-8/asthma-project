import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
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
              height: MediaQuery.of(context).size.height / 1.5,
              child: Pinput(
                autofocus: true,
                length: 4,
                onCompleted: (pin) {
                  context.pushAndRemoveUntil(view: const NavigatorBarScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
