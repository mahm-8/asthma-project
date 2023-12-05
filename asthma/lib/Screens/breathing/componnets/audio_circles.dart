import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class AudioCircles extends StatefulWidget {
  const AudioCircles({
    super.key,
  });

  @override
  State<AudioCircles> createState() => _AudioCirclesState();
}

double size = 195.0;
bool large = false;

class _AudioCirclesState extends State<AudioCircles> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedSize(
          reverseDuration: Duration(seconds: 5),
          duration: const Duration(seconds: 5),
          curve: Curves.easeIn,
          child: Container(
            height: size,
            decoration: BoxDecoration(
                color: ColorPaltte().lightgreentr, shape: BoxShape.circle),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 65,
          decoration: BoxDecoration(
              color: ColorPaltte().darkDarkGreen, shape: BoxShape.circle),
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
