import 'package:flutter/material.dart';

extension NavExtension on BuildContext {
  void pushAndRemoveUntil({required Widget view}) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => view),
      (route) => false,
    );
  }

  void push({required Widget view}) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => view),
    );
  }
}