import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle get bold24 =>
      const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
  TextStyle get titleFont => TextStyle(
      fontSize: 26, fontWeight: FontWeight.w800, color: ColorPaltte().darkBlue);
  TextStyle get titleFontwhite => TextStyle(
      fontSize: 26, fontWeight: FontWeight.w800, color: ColorPaltte().white);
  TextStyle get authFont =>
      TextStyle(color: ColorPaltte().fieldBlack, fontSize: 16);
  TextStyle get fontButton => const TextStyle(fontSize: 20);
  TextStyle get fontTextfield => TextStyle(color: ColorPaltte().fieldBlack);
  TextStyle get fontwhite =>
      TextStyle(color: ColorPaltte().white, fontSize: 18);

  TextStyle get qualityFont => TextStyle(
      fontSize: 24, fontWeight: FontWeight.w700, color: ColorPaltte().darkBlue);
  TextStyle get qualtyText => TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: ColorPaltte().darkBlue);

  TextStyle get quality => TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorPaltte().newDarkBlue);

  TextStyle get authGreyFont => TextStyle(
      color: ColorPaltte().authGrey, fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle get bold700 => const TextStyle(fontWeight: FontWeight.w700);
  TextStyle get titleOnboarding =>
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  TextStyle get detailsOnboarding =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get fieldFont => TextStyle(
      fontSize: 18, color: ColorPaltte().darkBlue, fontWeight: FontWeight.w500);

  TextStyle get fieldFont2 => TextStyle(
      fontSize: 19, color: ColorPaltte().darkBlue, fontWeight: FontWeight.w600);
  TextStyle get drawerTerm => const TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get fieldTitle => TextStyle(
      color: ColorPaltte().newDarkBlue,
      fontSize: 25,
      fontWeight: FontWeight.w800);

  TextStyle get darkblue700 => TextStyle(
      color: ColorPaltte().darkBlue, fontSize: 16, fontWeight: FontWeight.w700);
}
