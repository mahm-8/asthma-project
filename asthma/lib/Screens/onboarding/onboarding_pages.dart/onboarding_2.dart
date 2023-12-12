import 'package:asthma/helper/imports.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("lib/assets/images/Address-bro2.png"),
        const SizedBox(
          height: 25,
        ),
        Text(
          AppLocalizations.of(context)!.twoTitle,
          textAlign: TextAlign.center,
          style: const TextStyle().titleOnboarding,
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          AppLocalizations.of(context)!.twoDetails,
          textAlign: TextAlign.center,
          style: const TextStyle().detailsOnboarding,
        ),
      ],
    );
  }
}
