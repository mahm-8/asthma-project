import 'dart:typed_data';
import 'package:asthma/Screens/medication_data/component/data_card_widget.dart';
import 'package:asthma/Screens/medication_data/component/medication_bottomsheet.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationTrackerScreen extends StatefulWidget {
  const MedicationTrackerScreen({super.key});

  @override
  _MedicationTrackerScreenState createState() =>
      _MedicationTrackerScreenState();
}

class _MedicationTrackerScreenState extends State<MedicationTrackerScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPaltte().white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Medications',
          style: TextStyle(color: ColorPaltte().darkBlue),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorPaltte().darkBlue,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var container = Column(
                  children: [
                    ...allMedication.map(
                      (e) => Card(
                          child: Column(
                        children: [
                          Text(e.medicationName!),
                          Text(e.days!.toString()),
                          Text(e.date!)
                        ],
                      )),
                    )
                  ],
                );
                Uint8List? capturedImage =
                    await screenshotController.captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: const Duration(seconds: 1));
                await SupabaseServer().saveCaptrueImage(capturedImage);
                // saved(capturedImage);
              },
              icon: Icon(Icons.ios_share, color: ColorPaltte().darkBlue))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Your Medication',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorPaltte().darkBlue),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    showButtonSheet(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: ColorPaltte().newDarkBlue,
                      ),
                      Text(
                        'Add Medication',
                        style: TextStyle(
                          color: ColorPaltte().newDarkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<AsthmaBloc, AsthmaState>(
              buildWhen: (oldState, newState) {
                if (newState is SuccessGetMedicationState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SuccessGetMedicationState) {
                  if (state.medications.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.medications.length,
                        itemBuilder: (context, index) {
                          final medication = state.medications[index];
                          return DataCardWidget(
                            textEntry1: "name: ${medication.medicationName}",
                            textEntry2:
                                "days to take: ${medication.days.toString()}",
                            textEntry3: "start date: ${medication.date}",
                            deleteTap: () {
                              context.read<AsthmaBloc>().add(
                                    DeleteMedicationEvent(
                                        id: medication.medicationID!),
                                  );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No medication added",
                        style: TextStyle(
                            fontSize: 18, color: ColorPaltte().darkBlue),
                      ),
                    );
                  }
                } else if (state is ErrorGetState) {
                  const Center(child: Text("Error getting data"));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
