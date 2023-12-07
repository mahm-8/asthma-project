import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class AudioCircles extends StatefulWidget {
  const AudioCircles({
    super.key,
  });

  @override
  State<AudioCircles> createState() => _AudioCirclesState();
}

double size = 230;
bool large = false;

class _AudioCirclesState extends State<AudioCircles> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 5),
          curve: Curves.easeIn,
          child: Container(
            height: size,
            decoration: BoxDecoration(
                color: ColorPaltte().newlightBlue, shape: BoxShape.circle),
          ),
        ),
        Container(
          height: 140,
          decoration: BoxDecoration(
              color: ColorPaltte().newBlue, shape: BoxShape.circle),
        ),
        Container(
          alignment: Alignment.center,
          height: 60,
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
