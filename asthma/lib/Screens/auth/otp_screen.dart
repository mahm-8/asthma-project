import 'package:asthma/helper/imports.dart';

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
                child: Center(
                    child: Image.asset(
              color: Colors.white,
              "assets/mail.png",
              height: 150,
              width: 150,
            ))),
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
                      style: const TextStyle().authGreyFont,
                      children: [
                        const TextSpan(
                          text: "check otp code on your email",
                        ),
                        TextSpan(
                            text: AppLocalizations.of(context)!.email,
                            style: const TextStyle().bold700)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocListener<AuthBloc, AuthStates>(
                    listener: (context, state) {
                      if (state is SuccessVerificationState) {
                        context.read<AuthBloc>().add(CheckLoginEvent());
                        context.pushAndRemoveUntil(
                            view: const OnboradingScreen());
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
