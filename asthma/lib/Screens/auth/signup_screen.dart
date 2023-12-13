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
                    Text(AppLocalizations.of(context)!.create,
                        style: const TextStyle().bold24),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      keyForm: _userNameKey,
                      hint: AppLocalizations.of(context)!.name,
                      controller: nameController,
                      titel: AppLocalizations.of(context)!.name,
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
                    TextFieldWidget(
                      keyForm: _phoneKey,
                      hint: "05xxxxxxxx",
                      controller: phoneController,
                      titel: AppLocalizations.of(context)!.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.emptyNum;
                        }
                        if (!value.isValidPhone) {
                          return AppLocalizations.of(context)!.num;
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
                                return AppLocalizations.of(context)!.emptyPass;
                              }
                              if (!value.isValidPassword) {
                                return AppLocalizations.of(context)!.mustPass;
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
                          hint: AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          titel: AppLocalizations.of(context)!.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.emptyPass;
                            }
                            if (!value.isValidPassword) {
                              return AppLocalizations.of(context)!.mustPass;
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
                      buildWhen: (oldState, newState) {
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
                            AppLocalizations.of(context)!.signup,
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
                          TextSpan(text: AppLocalizations.of(context)!.already),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push(
                                      view: LoginScreen(),
                                    ),
                              text: AppLocalizations.of(context)!.loginHere,
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
