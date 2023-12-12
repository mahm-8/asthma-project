import 'package:asthma/Screens/Data_Symptoms_Screen/components/add_textfield.dart';
import 'package:asthma/Screens/breathing/componnets/button_widget.dart';
import 'package:asthma/blocs/asthma_bloc/asthma_bloc.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String selectedSymptom = 'cough';
String selectedLevel = 'Low';
TextEditingController symptomsDescriptionsController = TextEditingController();

Future<dynamic> showButtonSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Add Symptoms",
                  style: TextStyle(
                      color: ColorPaltte().newDarkBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Symptom",
                style: TextStyle(
                    fontSize: 18,
                    color: ColorPaltte().darkBlue,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: ColorPaltte().newlightBlue,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  iconDisabledColor: ColorPaltte().darkBlue,
                  iconEnabledColor: ColorPaltte().darkBlue,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  value: selectedSymptom,
                  hint: const Text('Select Symptom'),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: [
                    'cough',
                    'shortness of breath',
                    'Disordered sleep',
                  ].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedSymptom = value!;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Symptom Intensity",
                style: TextStyle(
                    fontSize: 18,
                    color: ColorPaltte().darkBlue,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    color: ColorPaltte().newlightBlue,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  iconDisabledColor: ColorPaltte().darkBlue,
                  iconEnabledColor: ColorPaltte().darkBlue,
                  borderRadius: BorderRadius.circular(20),
                  value: selectedLevel,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ['Low', 'Moderate', 'High'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedLevel = value!;
                  },
                ),
              ),
              const SizedBox(height: 16),
              AddTextfield(
                label: 'Details',
                fieldController: symptomsDescriptionsController,
                fieldWidth: MediaQuery.of(context).size.width * 0.95,
                fieldHeight: 135,
                onlyRead: false,
                title: 'Details',
              ),
              const SizedBox(height: 16),
              BlocListener<AsthmaBloc, AsthmaState>(
                listener: (context, state) {
                  if (state is SucsessMessageState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                    symptomsDescriptionsController.clear();
                    selectedSymptom = 'cough';
                    selectedLevel = 'Low';
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
                    context.read<AsthmaBloc>().add(AddSymptomEvent(
                        selectedSymptom,
                        symptomsDescriptionsController.text,
                        selectedLevel));

                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'cancel',
                      style: TextStyle(
                          color: ColorPaltte().darkBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )),
              )
            ],
          ),
        ),
      );
    },
  );
}