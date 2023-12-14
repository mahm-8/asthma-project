import 'package:dashboard/bloc/auth_bloc/auth_bloc.dart';
import 'package:dashboard/screens/auth/widgets/button_auth_widget.dart';
import 'package:dashboard/screens/auth/widgets/text_form_widget.dart';
import 'package:dashboard/screens/constants/colors.dart';
import 'package:dashboard/screens/extensions/loading_extension.dart';
import 'package:dashboard/screens/extensions/navigator.dart';
import 'package:dashboard/screens/extensions/screen_dimensions.dart';
import 'package:dashboard/screens/extensions/text.dart';
import 'package:dashboard/screens/extensions/validtor.dart';
import 'package:dashboard/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController(text: 'am18_8@outlook.com');
  final passwordController = TextEditingController(text: '12345Aa!');
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  bool display = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorPaltte().newDarkBlue,
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: context.getHeight(),
          child: ListView(
            children: [
              SizedBox(
                  height: 300,
                  child: Center(
                      child: Image.asset("lib/assets/logo.png",
                          color: Colors.white, height: 150, width: 150))),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(100))),
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(AppLocalizations.of(context)!.login,
                          style: const TextStyle().bold24),
                      const SizedBox(height: 10),
                      TextFieldWidget(
                        keyForm: _emailKey,
                        hint: "example@example.com",
                        controller: emailController,
                        titel: AppLocalizations.of(context)!.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.emptyEmail;
                          }
                          if (!value.isValidEmail) {
                            return AppLocalizations.of(context)!.mustEmail;
                          }
                          return null;
                        },
                      ),
                      BlocBuilder<AuthBloc, AuthStates>(
                        builder: (context, state) {
                          if (state is DisplayState) {
                            return TextFieldWidget(
                                onTap: () => context
                                    .read<AuthBloc>()
                                    .add(DisplayPasswordEvent(state.display)),
                                displayPass: state.display,
                                obscure: true,
                                keyForm: _passwordKey,
                                hint: AppLocalizations.of(context)!.password,
                                controller: passwordController,
                                titel: AppLocalizations.of(context)!.password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .emptyPass;
                                  }
                                  if (!value.isValidPassword) {
                                    return AppLocalizations.of(context)!
                                        .mustPass;
                                  }
                                  return null;
                                });
                          }
                          return TextFieldWidget(
                              onTap: () => context
                                  .read<AuthBloc>()
                                  .add(DisplayPasswordEvent(display)),
                              displayPass: display,
                              obscure: true,
                              keyForm: _passwordKey,
                              hint: AppLocalizations.of(context)!.password,
                              controller: passwordController,
                              titel: AppLocalizations.of(context)!.password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .emptyPass;
                                }
                                if (!value.isValidPassword) {
                                  return AppLocalizations.of(context)!.mustPass;
                                }
                                return null;
                              });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AuthBloc, AuthStates>(
                        builder: (context, state) {
                          return BlocListener<AuthBloc, AuthStates>(
                            listener: (context, state) {
                              if (state is LoginSuccessState) {
                                context.read<AuthBloc>().add(CheckLoginEvent());
                                context.pushAndRemoveUntil(
                                    view: const LoadingScreen());
                              } else if (state is ErrorAuthState) {
                                Navigator.of(context).pop();
                                context.showErrorMessage(msg: state.message);
                              } else if (state is ValidLoginState) {
                                Navigator.of(context).pop();
                              } else if (state is ErrorLoginState) {
                                Navigator.of(context).pop();
                                context.showErrorMessage(msg: state.msg);
                              }
                            },
                            child: ButtonAuthWidget(
                              onPressed: () {
                                context.read<AuthBloc>().add(LogInAuthEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    emailKey: _emailKey,
                                    passwordKey: _passwordKey));
                                context.showLoading();
                              },
                              text: AppLocalizations.of(context)!.login,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
