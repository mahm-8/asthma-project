import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:asthma/extensions/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../HomeScreen/home_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});
  final String email;
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
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SuccessVerificationState) {
                        context.pushAndRemoveUntil(view: const HomeScreen());
                      } else if (state is ErrorVerificationState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      }
                    },
                    child: Pinput(
                      autofocus: true,
                      length: 6,
                      onCompleted: (pin) {
                        context
                            .read<AuthBloc>()
                            .add(VerificationEvent(otp: pin, email: email));
                      },
                    ),
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
