// ignore_for_file: must_be_immutable

import 'package:asthma/Screens/HomeScreen/home_screen.dart';
import 'package:asthma/Screens/NavBar/nav_bar.dart';
import 'package:asthma/Screens/auth/otp_screen.dart';
import 'package:asthma/Screens/auth/signup_screen.dart';
import 'package:asthma/Screens/auth/widgets/button_auth_widget.dart';
import 'package:asthma/Screens/auth/widgets/text_form_widget.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/text.dart';
import 'package:asthma/extensions/validtor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  bool display = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorPaltte().darkBlue,
        body: Column(
          children: [
            Expanded(
                child: Center(
                    child: Image.asset(
              "assets/A.png",
              color: Colors.white,
              height: 150,
              width: 150,
            ))),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(100))),
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView(shrinkWrap: true, children: [
                Column(
                  children: [
                    Text("Login", style: const TextStyle().bold24),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      keyForm: _emailKey,
                      hint: "exambel@exambel.com",
                      controller: emailController,
                      titel: "EMAIL",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter email";
                        }
                        if (!value.isValidEmail) {
                          return "Email must be contain @ And .com";
                        }
                        return null;
                      },
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is DisplayState) {
                          return TextFieldWidget(
                            onTap: () => context
                                .read<AuthBloc>()
                                .add(DisplayPasswordEvent(state.display)),
                            displayPass: state.display,
                            obscure: true,
                            keyForm: _passwordKey,
                            hint: "Password",
                            controller: passwordController,
                            titel: "PASSWORD",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter password";
                              }
                              if (!value.isValidPassword) {
                                return "must be contain Uppercase, lowercase and (!@#*~)";
                              }
                              return null;
                            },
                          );
                        }
                        return TextFieldWidget(
                          onTap: () => context
                              .read<AuthBloc>()
                              .add(DisplayPasswordEvent(display)),
                          displayPass: display,
                          obscure: true,
                          keyForm: _passwordKey,
                          hint: "Password",
                          controller: passwordController,
                          titel: "PASSWORD",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter password";
                            }
                            if (!value.isValidPassword) {
                              return "must be contain Uppercase, lowercase and (!@#*~)";
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (oldstate, newstate) {
                        if (newstate is LoginSuccessState) {
                          context.push(
                              view: OtpScreen(
                            email: emailController.text,
                          ));
                        }
                        return false;
                      },
                      builder: (context, state) {
                        return BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is LoginSuccessState) {
                              context.pushAndRemoveUntil(view: HomeScreen());
                            } else if (state is ErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)));
                            }
                          },
                          child: ButtonAuthWidget(
                            onPressed: () {
                              context.read<AuthBloc>().add(LogInAuthEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  emailKey: _emailKey,
                                  passwordKey: _passwordKey));
                            },
                            text: 'Login',
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.push(view: SignupScreen()),
                              text: "Signup here",
                              style: const TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
