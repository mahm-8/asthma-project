import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class ButtonAuthWidget extends StatelessWidget {
  const ButtonAuthWidget({
    super.key,
    this.onPressed,
    required this.text,
  });
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorPaltte().darkBlue,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}