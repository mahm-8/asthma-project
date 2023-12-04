import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar(
      {super.key,
      required this.onPressed,
      required this.icons,
      required this.isSelect});
  final Function()? onPressed;
  final IconData icons;

  final bool isSelect;

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      focusElevation: 2,
      onPressed: widget.onPressed,
      minWidth: 10,
      child: Icon(
        widget.icons,
        color:
            widget.isSelect ? ColorPaltte().darkBlue : ColorPaltte().lightBlue,
      ),
    );
  }
}
