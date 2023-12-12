// ignore_for_file: must_be_immutable

import 'package:asthma/helper/imports.dart';

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
        backgroundColor: ColorPaltte().newDarkBlue,
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: context.getHeight(),
          child: ListView(
            children: [
              const SizedBox(
                height: 180,
              ),
              Container(
                decoration: BoxDecoration(
                    color: ColorPaltte().white,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(100))),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text("Create Account", style: const TextStyle().bold24),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      keyForm: _userNameKey,
                      hint: "Username",
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
                      hint: "example@example.com",
                      controller: emailController,
                      titel: "EMAIL",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter email";
                        }
                        if (!value.isValidEmail) {
                          return "email must be contain @ And .com";
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
                            hint: "Password",
                            controller: passwordController,
                            titel: "PASSWORD",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter password";
                              }
                              if (!value.isValidPassword) {
                                return "password must contain Uppercase, lowercase and (!@#*~)";
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
                              return "password must contain Uppercase, lowercase and (!@#*~)";
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<AuthBloc, AuthStates>(
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
                        return ButtonWidget(
                          onPress: () {
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
                          widget: Text(
                            "Sign Up",
                            style: const TextStyle().fontButton,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle().authFont,
                        children: [
                          const TextSpan(text: "Already Registerd? "),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push(
                                      view: LoginScreen(),
                                    ),
                              text: "Login",
                              style: const TextStyle().authGreyFont)
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
