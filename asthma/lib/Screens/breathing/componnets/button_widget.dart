import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.widget,
    this.onPress,
  });
  final Widget widget;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 350,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorPaltte().newDarkBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onPress,
          child: widget),
    );
  }
}
