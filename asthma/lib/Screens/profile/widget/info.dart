import 'package:asthma/helper/imports.dart';

class CardInfo extends StatelessWidget {
  const CardInfo(
      {super.key,
      required this.phone,
      required this.birthday,
      required this.email,
      required this.age,
      required this.gender});
  final String phone;
  final String birthday;
  final String email;
  final String age;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          if (phone.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.phone,
              subtitle: phone,
              icon: Icons.phone,
            ),
          const Divider(
            height: 0.5,
            color: Colors.black,
          ),
          if (email.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.email,
              subtitle: email,
              icon: Icons.email,
            ),
          const Divider(
            height: 0.5,
            color: Colors.black,
          ),
          if (age.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.age,
              subtitle: age,
              icon: Icons.date_range,
            ),
          const Divider(
            height: 0.5,
            color: Colors.black,
          ),
          if (birthday.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.birthday,
              subtitle: birthday,
              icon: Icons.calendar_month,
            ),
          const Divider(
            height: 0.5,
            color: Colors.black,
          ),
          if (gender.isNotEmpty)
            CardWidget(
                title: AppLocalizations.of(context)!.gender,
                subtitle: gender,
                icon: gender == 'male' ? Icons.male : Icons.female),
        ],
      ),
    );
  }
}
