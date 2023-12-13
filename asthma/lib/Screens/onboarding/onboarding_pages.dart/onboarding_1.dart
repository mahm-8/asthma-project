import '../../../helper/imports.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "lib/assets/images/Breathingexercise-blue.png",
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          AppLocalizations.of(context)!.oneTitle,
          textAlign: TextAlign.center,
          style: const TextStyle().titleOnboarding,
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          AppLocalizations.of(context)!.oneDetails,
          textAlign: TextAlign.center,
          style: const TextStyle().detailsOnboarding,
        ),
      ],
    );
  }
}
