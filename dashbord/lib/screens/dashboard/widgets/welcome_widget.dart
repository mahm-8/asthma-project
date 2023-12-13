import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 400,
          decoration: BoxDecoration(
              boxShadow: kElevationToShadow[1],
              color: Color.fromARGB(255, 148, 186, 203),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Image.asset(
                'lib/assets/Doctor-bro.png',
                width: 250,
                height: 250,
              ),
              Flexible(
                flex: 4,
                child: DatePickerDialog(
                    initialEntryMode: DatePickerEntryMode.calendar,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024)),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
