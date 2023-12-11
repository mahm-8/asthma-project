import 'package:barcode_widget/barcode_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:asthma/helper/imports.dart';

Future<dynamic> showCapturedWidget(
    BuildContext context, Uint8List capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text("Symptoms"),
        backgroundColor: ColorPaltte().white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorPaltte().darkBlue,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
          child: capturedImage != null
              ? Image.memory(capturedImage)
              : Container()),
    ),
  );
}

saved(image) async {
  final result = await ImageGallerySaver.saveImage(image);
}

generateBarcode(String userId) {
  return BarcodeWidget(
    data: userId,
    barcode: Barcode.qrCode(
      errorCorrectLevel: BarcodeQRCorrectionLevel.high,
    ),
  );
}
