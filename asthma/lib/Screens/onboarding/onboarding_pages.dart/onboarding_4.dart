import 'package:asthma/helper/imports.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "lib/assets/images/Asymptomatic-bro.png",
        ),
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
          AppLocalizations.of(context)!.threeTitle,
          textAlign: TextAlign.center,
          style: const TextStyle().detailsOnboarding,
        ),
      ],
    );
  }
}
