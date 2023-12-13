import 'package:asthma/helper/imports.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController(text: 'xbox-w@live.com');
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
              Center(
                child: SizedBox(
                    height: 300,
                    child: Center(
                        child: Image.asset("lib/assets/images/logo.png",
                            color: Colors.white, height: 150, width: 150))),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(100))),
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(AppLocalizations.of(context)!.login,
                          style: const TextStyle().bold24),
                      const SizedBox(height: 20),
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
                        height: 15,
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
                              }
                            },
                            child: ButtonWidget(
                              onPress: () {
                                context.read<AuthBloc>().add(LogInAuthEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    emailKey: _emailKey,
                                    passwordKey: _passwordKey));
                                context.showLoading();
                              },
                              widget: Text(
                                AppLocalizations.of(context)!.login,
                                style: const TextStyle().fontButton,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle().authFont,
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => context.push(view: SignupScreen()),
                                text: AppLocalizations.of(context)!.signupHere,
                                style: const TextStyle().authGreyFont),
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
      ),
    );
  }
}
