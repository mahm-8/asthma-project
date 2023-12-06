import 'package:asthma/Screens/breathing/componnets/button_widget.dart';
import 'package:asthma/Screens/medication/components/add_textfield.dart';
import 'package:asthma/constants/colors.dart';
import 'package:flutter/material.dart';

class AddSymptomsScreen extends StatelessWidget {
  const AddSymptomsScreen({super.key});

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
                "assets/stack_background.png",
                color: ColorPaltte().lightgreen,
              )),
          Positioned(
              left: -185,
              top: 300,
              child: Image.asset(
                "assets/stack_background.png",
                color: ColorPaltte().lightgreen,
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Add Symptoms",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
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
                      ButtonWidget(
                        widget: const Text(
                          "Add",
                          style: TextStyle(color: Colors.black, fontSize: 18),
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
