// ignore_for_file: use_build_context_synchronously

import 'package:asthma/helper/imports.dart';

ScreenshotController screenshotController = ScreenshotController();

AppBar customAppBar(BuildContext context,
    {bool hasAction = false,
    bool showtitle = false,
    String? title,
    required Color backcolor,
    required Color iconColor}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: backcolor,
    title: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Visibility(
        visible: showtitle,
        child: Text("${title}",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: ColorPaltte().darkBlue)),
      ),
    ),
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
                                    style: const TextStyle().detailsOnboarding,
                                  ),
                                  Text(
                                    "details: ${e.symptomDetails!}",
                                    style: const TextStyle().detailsOnboarding,
                                  ),
                                  Text(
                                    "intensity: ${e.symptomIntensity!}",
                                    style: const TextStyle().detailsOnboarding,
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
