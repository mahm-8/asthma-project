import 'dart:typed_data';
import 'package:asthma/Screens/Data_Symptoms_Screen/symptom_bottomsheet.dart';
import 'package:asthma/Screens/medication_data/component/data_card_widget.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/blocs/user_bloc/user_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
Widget? barcode;
String? imageUrl;
class SymptomTrackerScreen extends StatefulWidget {
  const SymptomTrackerScreen({super.key});

  @override
  _SymptomTrackerScreenState createState() => _SymptomTrackerScreenState();
}

class _SymptomTrackerScreenState extends State<SymptomTrackerScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    context.read<AsthmaBloc>().add(GetSymptomDataEvent());
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPaltte().white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Symptoms',
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
                    ...allSymptoms.map(
                      (e) => Card(
                          child: Column(
                        children: [
                          Text(e.symptomName!),
                          Text(e.symptomDetails!),
                          Text(e.symptomIntensity!)
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
                context
                    .read<UserBloc>()
                    .add(UploadImageCaptureEvent(capturedImage));
              },
              icon: Icon(Icons.ios_share, color: ColorPaltte().darkBlue))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Your symptoms',
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
                        'Add Symptom',
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
                if (newState is SuccessGetSymptomState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SuccessGetSymptomState) {
                  if (state.symptoms.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.symptoms.length,
                        itemBuilder: (context, index) {
                          final symptom = state.symptoms[index];
                          return DataCardWidget(
                              textEntry1: "Symptom: ${symptom.symptomName}",
                              textEntry2: "Details: ${symptom.symptomDetails}",
                              textEntry3:
                                  "intensity: ${symptom.symptomIntensity}",
                              deleteTap: () {
                                context.read<AsthmaBloc>().add(
                                    DeleteSymptomEvent(id: symptom.symptomID!));
                              });
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No symptoms added",
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
