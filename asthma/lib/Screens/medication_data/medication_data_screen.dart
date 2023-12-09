import 'dart:typed_data';
import 'package:asthma/Screens/Data_Symptoms_Screen/components/add_textfield.dart';
import 'package:asthma/Screens/breathing/componnets/button_widget.dart';
import 'package:asthma/Screens/medication_data/component/data_card_widget.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/blocs/auth_bloc/auth_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:screenshot/screenshot.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asthma/Services/supabase.dart';

class MedicationTrackerScreen extends StatefulWidget {
  const MedicationTrackerScreen({super.key});

  @override
  _MedicationTrackerScreenState createState() =>
      _MedicationTrackerScreenState();
}

class _MedicationTrackerScreenState extends State<MedicationTrackerScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController medicationNameController = TextEditingController(),
      medicationQuantitysController = TextEditingController(),
      medicationDateController = TextEditingController(),
      medicationDaysController = TextEditingController();

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

  Future<dynamic> showButtonSheet(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.75),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
            
                const SizedBox(height: 16),
                AddTextfield(
                  label: 'Medication Name',
                  fieldController: medicationNameController,
                  fieldWidth: MediaQuery.of(context).size.width * 0.95,
                  fieldHeight: 55,
                  onlyRead: false,
                  title: 'Medication Name',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddTextfield(
                      label: 'Quantity in day',
                      fieldController: medicationQuantitysController,
                      fieldWidth: MediaQuery.of(context).size.width * 0.44,
                      fieldHeight: 55,
                      onlyRead: false,
                      title: 'Quantity in day',
                    ),
                    AddTextfield(
                      label: 'No. of Days to take',
                      fieldController: medicationDaysController,
                      fieldWidth: MediaQuery.of(context).size.width * 0.44,
                      fieldHeight: 55,
                      onlyRead: false,
                      title: 'days',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                AddTextfield(
                  onTapped: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2024));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      medicationDateController.text = formattedDate;
                    } else {
                      print("Date is not selected");
                    }
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: ColorPaltte().newDarkBlue,
                  ),
                  label: 'Start Date',
                  fieldController: medicationDateController,
                  fieldWidth: MediaQuery.of(context).size.width,
                  fieldHeight: 55,
                  onlyRead: true,
                  title: 'Start Date',
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocListener<AsthmaBloc, AsthmaState>(
                  listener: (context, state) {
                    if (state is SucsessMessageState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      medicationNameController.clear();
                      medicationDaysController.clear();
                      medicationDateController.clear();
                    } else if (state is ADDErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  child: ButtonWidget(
                    widget: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPress: () {
                      context.read<AsthmaBloc>().add(AddMedicationEvent(
                          medicationNameController.text,
                          int.parse(medicationDaysController.text),
                          medicationDateController.text));

                      Navigator.pop(context);
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'cancel',
                      style: TextStyle(
                          color: ColorPaltte().darkBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
