import 'package:asthma/Screens/breathing/componnets/button_widget.dart';
import 'package:asthma/Services/supabase.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/add_textfield.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

TextEditingController medicationNameController = TextEditingController(),
    medicationQuantitysController = TextEditingController(),
    medicationDateController = TextEditingController(),
    medicationDaysController = TextEditingController();

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned(
              right: -185,
              bottom: 55,
              child: Image.asset(
                "lib/assets/images/stack_background.png",
                color: ColorPaltte().newBlue,
              )),
          Positioned(
              left: -185,
              top: 300,
              child: Image.asset(
                "lib/assets/images/stack_background.png",
                color: ColorPaltte().newBlue,
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "إضافة الدواء",
                          style: TextStyle(
                              color: ColorPaltte().newDarkBlue,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AddTextfield(
                          label: 'اسم الدواء',
                          fieldController: medicationNameController,
                          fieldWidth: MediaQuery.of(context).size.width * 0.95,
                          fieldHeight: 55,
                          onlyRead: false,
                          title: 'اسم الدواء',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AddTextfield(
                              label: 'عدد الحبات في اليوم',
                              fieldController: medicationQuantitysController,
                              fieldWidth:
                                  MediaQuery.of(context).size.width * 0.44,
                              fieldHeight: 55,
                              onlyRead: false,
                              title: 'عدد الحبات في اليوم',
                            ),
                            AddTextfield(
                              label: 'عدد أيام اخذ الدواء',
                              fieldController: medicationDaysController,
                              fieldWidth:
                                  MediaQuery.of(context).size.width * 0.44,
                              fieldHeight: 55,
                              onlyRead: false,
                              title: 'الايام',
                            ),
                          ],
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
                          label: 'تاريخ البدء',
                          fieldController: medicationDateController,
                          fieldWidth: MediaQuery.of(context).size.width,
                          fieldHeight: 55,
                          onlyRead: true,
                          title: 'تاريخ البدء',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonWidget(
                          widget: Text(
                            "إضافة الدواء",
                            style: TextStyle(
                                color: ColorPaltte().white, fontSize: 18),
                          ),
                          onPress: () {
                            // submit add
                            if (medicationNameController.text.isNotEmpty &&
                                medicationDaysController.text.isNotEmpty &&
                                medicationDateController.text.isNotEmpty) {
                              SupabaseServer().addMedication({
                                "name": medicationNameController.text,
                                "days": medicationDaysController.text,
                                "date": medicationDateController.text,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("تمت إضافة الدواء")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("الرجاء ملء جميع الحقول")));
                            }
                          },
                        ),
                      ],
                    ),
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
