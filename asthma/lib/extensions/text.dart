import 'dart:ui';

import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle get newColor => const TextStyle(
      color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold);
      
}