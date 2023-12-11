import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/Screens/loading/loading_screen.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/loading_extension.dart';
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
        backgroundColor: ColorPaltte().newDarkBlue,
        resizeToAvoidBottomInset: false,
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
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      children: const [
                        TextSpan(
                          text: "check otp code on your ",
                        ),
                        TextSpan(
                            text: "Email ",
                            style: TextStyle(fontWeight: FontWeight.w700))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SuccessVerificationState) {
                        context.pushAndRemoveUntil(view: const LoadingScreen());
                      } else if (state is ErrorVerificationState) {
                        Navigator.of(context).pop();
                        context.showErrorMessage(msg: state.message);
                      }
                    },
                    child: Pinput(
                      autofocus: true,
                      length: 6,
                      onCompleted: (pin) {
                        context
                            .read<AuthBloc>()
                            .add(VerificationEvent(otp: pin, email: email));
                        context.showLoading();
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
