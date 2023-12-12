// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';
import 'package:asthma/constants/colors.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<dynamic> ShowCapturedWidget(
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

generateBarcode(String imageUrl) {
  return BarcodeWidget(
    data: imageUrl,
    barcode: Barcode.qrCode(
      errorCorrectLevel: BarcodeQRCorrectionLevel.high,
    ),
  );
}
