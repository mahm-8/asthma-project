import 'package:flutter/material.dart';

class CardUser extends StatelessWidget {
  const CardUser({super.key, required this.title, required this.isUser});
  final String title;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: isUser
            ? const EdgeInsets.only(top: 16, right: 4, left: 25)
            : const EdgeInsets.only(top: 16, left: 4, right: 25),
        // constraints: const BoxConstraints(
        //     maxHeight: 300, maxWidth: 200, minHeight: 60, minWidth: 100),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isUser ? const Color.fromARGB(255, 19, 12, 53) : Colors.grey[800],
        ),
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
