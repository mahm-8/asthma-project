import 'package:asthma/Screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class DataSymptomsScreen extends StatelessWidget {
  DataSymptomsScreen({super.key});
  final screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screenshot(
      controller: screenshotController,
      child: Column(
        children: [
          const Text('sssssss'),
          const Text('sssssss'),
          const Text('sssssss'),
          const Text('sssssss'),
          ElevatedButton(
              onPressed: () {
                screenshotController.captureFromWidget(const HomeScreen());
                screenshotController
                    .captureFromWidget(const HomeScreen(),
                        delay: const Duration(seconds: 1))
                    .then((value) {
                  final image = value;
                  print(image);
                });
              },
              child: const Text("Capture")),
        ],
      ),
    ));
  }
}
