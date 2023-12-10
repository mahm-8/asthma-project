import 'package:flutter/material.dart';

//test animation
//test animation

class SizeAnimated extends StatefulWidget {
  const SizeAnimated({super.key});

  @override
  State<SizeAnimated> createState() => _SizeAnimatedState();
}

class _SizeAnimatedState extends State<SizeAnimated> {
  double boxHeight = 100;
  double boxWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  boxHeight = 500;
                  boxWidth = 500;
                });
              },
              child: const Text("change size")),
          Center(
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 2),
              height: boxHeight,
              width: boxWidth,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
