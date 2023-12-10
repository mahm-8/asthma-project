import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class AudioCircles extends StatefulWidget {
  const AudioCircles({
    super.key,
  });

  @override
  State<AudioCircles> createState() => _AudioCirclesState();
}

double backCircleHeight = 230;
double middleCircleHeight = 120;
double frontCircleHeight = 60;

bool large = false;

class _AudioCirclesState extends State<AudioCircles> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 2),
          child: Container(
            height: backCircleHeight,
            decoration: BoxDecoration(
                color: ColorPaltte().newlightBlue, shape: BoxShape.circle),
          ),
        ),
        Container(
          height: middleCircleHeight,
          decoration: BoxDecoration(
              color: ColorPaltte().newBlue, shape: BoxShape.circle),
        ),
        Container(
          alignment: Alignment.center,
          height: frontCircleHeight,
          decoration: BoxDecoration(
              color: ColorPaltte().newDarkBlue, shape: BoxShape.circle),
          child: const Text(
            "0s",
            // "${audioDuration}s",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
