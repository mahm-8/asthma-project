import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

AppBar homeCustomAppBar(
    {required AdvancedDrawerController controller,
    required Function()? onPress}) {
  return AppBar(
    backgroundColor: ColorPaltte().newDarkBlue,
    elevation: 0,
    leading: IconButton(
      onPressed: onPress,
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: controller,
        builder: (_, value, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              value.visible ? Icons.clear : Icons.menu,
              key: ValueKey<bool>(value.visible),
            ),
          );
        },
      ),
    ),
  );
}
