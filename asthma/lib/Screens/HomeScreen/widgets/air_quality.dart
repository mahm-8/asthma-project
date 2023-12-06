import 'package:asthma/Screens/HomeScreen/home_screen%20copy.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AirQuality extends StatelessWidget {
  const AirQuality({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorPaltte().lightgreentr,
          borderRadius: BorderRadius.circular(10)),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              '$value%',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorPaltte().darkBlue),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'air quality:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorPaltte().darkBlue),
            ),
            Text(
              ' normal',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorPaltte().mBlue),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text('Emergency Call'),
                        content:
                            Text('Are you sure you want to call emergency?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Uri tel = Uri.parse('tel:+966 507 625 994');
                              await launchUrl(tel);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Call',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.phone_enabled_rounded,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
