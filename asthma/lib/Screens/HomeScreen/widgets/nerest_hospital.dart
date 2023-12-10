import 'package:asthma/Models/location_model.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
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
          // if (state is LoadingState)
          //   Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // if (state is SuccessHospitalState)
          if (nearestLocations.isNotEmpty)
            Container(
              height: context.getHeight() * 0.21,
              width: context.getWidth(),
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
                    child: Container(
                      width: context.getWidth(divide: 2.2),
                      height: context.getWidth(divide: 1.9),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'lib/assets/images/Address-bro2.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Text(
                                location.name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorPaltte().darkBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
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
                                    '${(location.distance! / 1000).toStringAsFixed(2)} km',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          // else if (state is ErrorState)
          //   Text("Error"),
        ],
      );
    });
  }
}
