import 'package:flutter/cupertino.dart';
import 'package:asthma/helper/imports.dart';

showDatePickerWidget(
    {required BuildContext context,
    Function(String)? onDateTimeChanged}) async {
  return await showCupertinoModalPopup<void>(
    context: context,
    builder: (_) {
      final size = context.getHeight(divide: 3);
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        height: size,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Done"))),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  if (onDateTimeChanged != null) {
                    onDateTimeChanged(
                        "${value.year}/${value.day}/${value.month}");
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
