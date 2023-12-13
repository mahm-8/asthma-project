import 'package:dashboard/screens/profaile/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ProfaileScreen extends StatelessWidget {
  const ProfaileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'lib/assets/image.jpg',
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Column(
                children: [
                  Text('Wadha Almutairi'),
                  Text('Doctor'),
                  Text('0507625994'),
                  Text('20/3/2023')
                ],
              ),
              const ProfaileTextField(),
              DatePickerDialog(
                  firstDate: DateTime.now(), lastDate: DateTime(2024))
            ],
          ),
        ],
      ),
    );
  }
}
