import 'package:asthma/Screens/HomeScreen/home_screen.dart';
import 'package:asthma/Screens/HomeScreen/widgets/medication_reminder.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class DataSymptomsScreen extends StatelessWidget {
  DataSymptomsScreen({super.key});
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screenshot(
      controller: screenshotController,
      child: Column(
        children: [
          Text('sssssss'),
          Text('sssssss'),
          Text('sssssss'),
          Text('sssssss'),
          ElevatedButton(
              onPressed: () {
                screenshotController.captureFromWidget(HomeScreen());
                screenshotController
                    .captureFromWidget(HomeScreen(),
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
