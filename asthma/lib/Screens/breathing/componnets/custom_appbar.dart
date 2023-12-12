// ignore_for_file: use_build_context_synchronously

import 'package:asthma/helper/imports.dart';

ScreenshotController screenshotController = ScreenshotController();

AppBar customAppBar(BuildContext context,
    {bool hasAction = false,
    required Color backcolor,
    required Color iconColor}) {
  return AppBar(
    elevation: 0,
    backgroundColor: backcolor,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: iconColor,
          ),
        )),
    actions: [
      Visibility(
        visible: hasAction,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
              onPressed: () async {
                var container = Column(
                  children: [
                    ...allSymptoms.map(
                      (e) => SizedBox(
                        width: 300,
                        child: Card(
                            color: ColorPaltte().white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "symptom: ${e.symptomName!}",
                                    style: TextStyle().detailsOnboarding,
                                  ),
                                  Text(
                                    "details: ${e.symptomDetails!}",
                                    style: TextStyle().detailsOnboarding,
                                  ),
                                  Text(
                                    "intensity: ${e.symptomIntensity!}",
                                    style: TextStyle().detailsOnboarding,
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                );
                Uint8List? capturedImage =
                    await screenshotController.captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: const Duration(seconds: 1));
                context
                    .read<UserBloc>()
                    .add(UploadImageCaptureEvent(capturedImage));
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          content: Text("symptoms captured as QR code"),
                        ));
              },
              icon: Icon(Icons.ios_share, color: ColorPaltte().white)),
        ),
      )
    ],
  );
}
