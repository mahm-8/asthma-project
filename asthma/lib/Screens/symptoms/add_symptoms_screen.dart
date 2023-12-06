import 'package:asthma/Screens/breathing/componnets/button_widget.dart';
import 'package:asthma/Screens/medication/components/add_textfield.dart';
import 'package:asthma/constants/colors.dart';
import 'package:asthma/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';

class AddSymptomsScreen extends StatefulWidget {
  AddSymptomsScreen({super.key});

  @override
  State<AddSymptomsScreen> createState() => _AddSymptomsScreenState();
}

class _AddSymptomsScreenState extends State<AddSymptomsScreen> {
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController symptomsTitleNameController = TextEditingController(),
        symptomsDetailssController = TextEditingController();
    return Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Add Symptoms",
                        style: TextStyle(
                            color: ColorPaltte().newDarkBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      AddTextfield(
                        label: 'Symptoms title',
                        fieldController: symptomsTitleNameController,
                        fieldWidth: MediaQuery.of(context).size.width * 0.95,
                        fieldHeight: 55,
                      ),
                      AddTextfield(
                        label: 'details',
                        fieldController: symptomsDetailssController,
                        fieldWidth: MediaQuery.of(context).size.width * 0.95,
                        fieldHeight: 135,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorPaltte().newlightBlue,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonFormField(
                          iconDisabledColor: ColorPaltte().darkBlue,
                          iconEnabledColor: ColorPaltte().darkBlue,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                          borderRadius: BorderRadius.circular(20),
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(color: ColorPaltte().darkBlue),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonWidget(
                        widget: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPress: () {
                          // submit add
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
