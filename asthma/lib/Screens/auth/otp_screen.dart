import 'package:asthma/Screens/NavBar/nav_bar.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
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
