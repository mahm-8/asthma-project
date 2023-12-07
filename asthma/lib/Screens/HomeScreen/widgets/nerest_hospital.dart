import 'package:asthma/Models/location_model.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NerestHospital extends StatelessWidget {
  const NerestHospital({
    super.key,
    required this.nearestLocations,
  });

  final List<LocationModel> nearestLocations;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AsthmaBloc>();
    return BlocBuilder<AsthmaBloc, AsthmaState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (nearestLocations.isNotEmpty)
            Container(
              height: 90,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: nearestLocations.length,
                itemBuilder: (context, index) {
                  LocationModel location = nearestLocations[index];
                  return InkWell(
                    onTap: () async {
                      final latitude = bloc.hospitalData!.latitude;
                      final longitude = bloc.hospitalData!.longitude;
                      final url =
                          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                      await launchUrl(Uri.parse(url));
                    },
                    child: Card(
                      color: ColorPaltte().newlightBlue,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location.name!,
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
                                        '${(location.distance! / 1000).toStringAsFixed(2)} km'),
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
    });
  }
}
