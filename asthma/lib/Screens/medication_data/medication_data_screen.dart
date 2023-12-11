import 'package:asthma/Screens/medication_data/component/data_card_widget.dart';
import 'package:asthma/Screens/medication_data/component/medication_bottomsheet.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationTrackerScreen extends StatefulWidget {
  const MedicationTrackerScreen({super.key});

  @override
  _MedicationTrackerScreenState createState() =>
      _MedicationTrackerScreenState();
}

class _MedicationTrackerScreenState extends State<MedicationTrackerScreen> {
  @override
  void initState() {
    context.read<AsthmaBloc>().add(GetMedicationDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPaltte().newDarkBlue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorPaltte().white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: context.getWidth(),
            decoration: BoxDecoration(
                color: ColorPaltte().newDarkBlue,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            height: 300,
          ),
          Positioned(
            top: -100,
            right: 50,
            child: Image.asset(
              'lib/assets/images/Doctor-bro.png',
              width: 500,
              height: 500,
            ),
          ),
          Positioned(
            left: 175,
            top: 120,
            child: Text(
              "Medications",
              style: TextStyle(
                  fontSize: 35,
                  color: ColorPaltte().white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 320,
                  ),
                  Row(
                    children: [
                      Text(
                        'Your Medication',
                        style: TextStyle(
                            fontSize: 24,
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
                              color: ColorPaltte().darkBlue,
                            ),
                            Text(
                              'Add Medication',
                              style: TextStyle(
                                color: ColorPaltte().darkBlue,
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
                                  textEntry1:
                                      "name: ${medication.medicationName}",
                                  textEntry2:
                                      "days to take: ${medication.days.toString()}",
                                  textEntry3: "start date: ${medication.date}",
                                  deleteTap: () {
                                    context.read<AsthmaBloc>().add(
                                          DeleteMedicationEvent(
                                              id: medication.medicationID!),
                                        );
                                  },
                                  imageURL: 'lib/assets/images/pills.png',
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
