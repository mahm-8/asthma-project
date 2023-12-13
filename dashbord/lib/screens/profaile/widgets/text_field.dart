
import 'package:flutter/material.dart';

class ProfaileTextField extends StatelessWidget {
  const ProfaileTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text('Name '),
        TextField(),
      ],
    );
  }
}