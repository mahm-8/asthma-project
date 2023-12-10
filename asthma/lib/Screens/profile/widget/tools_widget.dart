import 'package:flutter/material.dart';

class ToolsWidget extends StatelessWidget {
  const ToolsWidget(
      {super.key,
      required this.title,
      this.onPressed,
      this.colorText = Colors.black});
  final String title;
  final Function()? onPressed;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 55,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: colorText),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
