import 'package:asthma/Models/location_model.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NerestHospital extends StatelessWidget {
  const NerestHospital({
    super.key,
    required this.nearestLocations,
  });

  final List<Location> nearestLocations;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (nearestLocations.isNotEmpty)
          Container(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nearestLocations.length,
              itemBuilder: (context, index) {
                Location location = nearestLocations[index];
                return InkWell(
                  onTap: () async {
                    final latitude = 24.559035517748324;
                    final longitude = 46.63795466736618;
                    final url =
                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                    await launchUrl(Uri.parse(url));
                  },
                  child: Card(
                    color: ColorPaltte().lightBlue,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   'lib/assets/images/hospital.png',
                          //   width: 80,
                          //   height: 80,
                          // ),
                          // const Divider(
                          //   thickness: 1,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location.name,
                                style: TextStyle(
                                    color: ColorPaltte().darkBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                  ),
                                  Text(
                                      '${(location.distance / 1000).toStringAsFixed(2)} km'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}
