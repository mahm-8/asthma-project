import 'package:asthma/helper/imports.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("lib/assets/images/Chatbot-pana.png"),
        const SizedBox(
          height: 25,
        ),
        Text(
          AppLocalizations.of(context)!.threeTitle,
          textAlign: TextAlign.center,
          style: const TextStyle().titleOnboarding,
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          AppLocalizations.of(context)!.threeDetails,
          textAlign: TextAlign.center,
          style: const TextStyle().detailsOnboarding,
        ),
      ],
    );
  }
}
