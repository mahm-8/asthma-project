import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'card_widget.dart';

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
          const SizedBox(height: 10),
          if (email.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.email,
              subtitle: email,
              icon: Icons.email,
            ),
          const SizedBox(height: 10),
          if (age.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.age,
              subtitle: age,
              icon: Icons.date_range,
            ),
          const SizedBox(height: 10),
          if (birthday.isNotEmpty)
            CardWidget(
              title: AppLocalizations.of(context)!.birthday,
              subtitle: birthday,
              icon: Icons.calendar_month,
            ),
          const SizedBox(height: 10),
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
