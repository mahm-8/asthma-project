import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class AddTextfield extends StatelessWidget {
  const AddTextfield({
    super.key,
    required this.label,
    required this.fieldController,
    required this.fieldWidth,
    this.icon,
    this.fieldHeight,
  });
  final String label;
  final TextEditingController fieldController;
  final double? fieldHeight;

  final double fieldWidth;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        alignment: Alignment.center,
        width: fieldWidth,
        height: fieldHeight,
        decoration: BoxDecoration(
            color: ColorPaltte().newlightBlue,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
              cursorColor: ColorPaltte().darkBlue,
              textAlign: TextAlign.left,
              controller: fieldController,
              decoration: InputDecoration(
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: icon,
                hintText: label,
                hintStyle: TextStyle(color: ColorPaltte().darkBlue),
              )),
        ),
      ),
    );
  }
}
