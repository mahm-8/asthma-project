import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  ContainerWidget({
    super.key,
    required this.imageurl,
    required this.title,
    required this.onTap,
  });
  final String imageurl;
  final String title;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.getWidth(divide: 2.6),
        height: context.getWidth(divide: 2.6),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageurl,
                width: 110,
                height: 110,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorPaltte().darkBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
