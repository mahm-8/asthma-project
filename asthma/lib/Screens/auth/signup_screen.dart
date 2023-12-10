// ignore_for_file: must_be_immutable

import 'package:asthma/Screens/auth/login_screen.dart';
import 'package:asthma/Screens/auth/otp_screen.dart';
import 'package:asthma/Screens/auth/widgets/button_auth_widget.dart';
import 'package:asthma/Screens/auth/widgets/text_form_widget.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/loading_extension.dart';
import 'package:asthma/extensions/navigator.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:asthma/extensions/text.dart';
import 'package:asthma/extensions/validtor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _userNameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  bool display = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: context.getHeight(),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Create new Account", style: const TextStyle().bold24),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      keyForm: _userNameKey,
                      hint: "UserName",
                      controller: nameController,
                      titel: "NAME",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter name";
                        }
                        return null;
                      },
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
                    TextFieldWidget(
                      keyForm: _phoneKey,
                      hint: "05xxxxxxxx",
                      controller: phoneController,
                      titel: "Phone",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your number";
                        }
                        if (!value.isValidPhone) {
                          return "10 number";
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
                    SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (oldStete, newState) {
                        if (newState is SignUpSuccessState) {
                          context.push(
                              view: OtpScreen(
                            email: emailController.text,
                          ));
                        } else if (newState is ValidSignUpState) {
                          Navigator.of(context).pop();
                        }
                        return false;
                      },
                      builder: (context, state) {
                        return ButtonAuthWidget(
                          text: "SignUp",
                          onPressed: () {
                            context.read<AuthBloc>().add(SignUpAuthEvent(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text,
                                _userNameKey,
                                _emailKey,
                                _passwordKey,
                                _phoneKey));
                            context.showLoading();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          const TextSpan(text: "Already Register? "),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push(
                                      view: LoginScreen(),
                                    ),
                              text: "Login here",
                              style: TextStyle(color: Colors.grey[700]))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
