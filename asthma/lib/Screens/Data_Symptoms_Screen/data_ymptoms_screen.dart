import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

class DataSymptomsScreen extends StatefulWidget {
  DataSymptomsScreen({super.key});

  @override
  State<DataSymptomsScreen> createState() => _DataSymptomsScreenState();
}

class _DataSymptomsScreenState extends State<DataSymptomsScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  int counter = 0;
  List symptoms = [];
  Uint8List? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screenshot(
      controller: screenshotController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This text will be captured as image"),
          ElevatedButton(
              onPressed: () async {
                var container = ListView.builder(
                  itemCount: symptoms.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('name'),
                      subtitle: Text('description'),
                      trailing: Text('Low'),
                    );
                  },
                );
                screenshotController
                    .captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: Duration(seconds: 1))
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                  _saved(capturedImage);
                });
              },
              child: const Text("Capture")),
        ],
      ),
    ));
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  _saved(image) async {
    // final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }
}
