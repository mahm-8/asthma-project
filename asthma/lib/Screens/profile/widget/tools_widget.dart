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
    return InkWell(
      onTap: onPressed,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        const Divider(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(title, style: TextStyle(color: colorText)),
          ),
        ),
      ]),
    );
  }
}
